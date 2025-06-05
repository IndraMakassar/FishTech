import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fishtech/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;
  late final StreamSubscription<AuthStateChange> _authSub;

  AuthBloc(this._repo) : super(AuthInitial()) {
    // 1) bootstrap from whatever session is already live:
    _repo.checkSession().then((sess) {
      if (sess != null) {
        add(UserLoggedIn(sess));
      } else {
        add(UserLoggedOut());
      }
    });

    // 2) now listen for *only* signIn / signOut, drop duplicates
    _authSub = _repo.onAuthStateChange.listen((change) {
      switch (change.event) {
        case AuthChangeEvent.initialSession:
          if (change.session != null) {
            add(UserLoggedIn(change.session!));
          } else {
            add(UserLoggedOut());
          }
          break;

        case AuthChangeEvent.signedIn:
        case AuthChangeEvent.tokenRefreshed:
          if (change.session != null && state is! AuthAuthenticated) {
            add(UserLoggedIn(change.session!));
          }
          break;

        case AuthChangeEvent.signedOut:
        case AuthChangeEvent.userDeleted:
          if (state is! AuthUnauthenticated) {
            add(UserLoggedOut());
          }
          break;

        default:
        // ignore
      }
    });


    // 3) your handlers become trivial:
    on<UserLoggedIn>((e, emit) => emit(AuthAuthenticated(e.session)));
    on<UserLoggedOut>((e, emit) => emit(AuthUnauthenticated()));

    on<UserSignUp>((e, emit) async {
      emit(const AuthLoading(loadingType: AuthLoadingType.email));
      try {
        final response = await _repo.signUpWithEmail(e.name, e.email, e.password);
        // stream will fire signedIn → UserLoggedIn
        emit(AuthAuthenticated(response.session!));
      } on AuthException catch (err) {
        emit(AuthFailure(err.message));
      } catch (_) {
        emit(const AuthFailure("Unexpected error"));
      }
    });

    on<UserSignIn>((e, emit) async {
      emit(const AuthLoading(loadingType: AuthLoadingType.email));
      try {
        await _repo.signInWithEmail(e.email, e.password);
        // stream will fire signedIn → UserLoggedIn
      } on AuthException catch (err) {
        emit(AuthFailure(err.message));
      } catch (_) {
        emit(const AuthFailure("Unexpected error"));
      }
    });

    on<UserSignOut>((e, emit) async {
      emit(const AuthLoading(loadingType: AuthLoadingType.email));
      try {
        await FirebaseMessaging.instance.deleteToken();
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('fcm_token');
        await _repo.signOut();
        emit(AuthInitial());
        // stream will fire signedOut → UserLoggedOut
      } on AuthException catch (err) {
        emit(AuthFailure(err.message));
      } catch (_) {
        emit(const AuthFailure("Unexpected error"));
      }
    });

    on<UserChangeName>((e, emit) async {
      emit(const AuthLoading(loadingType: AuthLoadingType.profile));
      try {
        await _repo.changeName(e.newName);
        // (no explicit success‑emit here; you could fetch session again if you like)
      } on AuthException catch (err) {
        emit(AuthFailure(err.message));
      } catch (_) {
        emit(const AuthFailure("Unexpected error"));
      }
    });

    on<UserChangeToken>((e, emit) async {
      if (state is AuthAuthenticated) {
        emit(AuthLoadingWhileAuthenticated(
          session: (state as AuthAuthenticated).session,
          loadingType: AuthLoadingType.profile,
        ));

        try {
          await _repo.changeToken(e.newToken);
          emit(AuthAuthenticated((state as AuthLoadingWhileAuthenticated).session));
        } on AuthException catch (e) {
          emit(AuthFailure(e.message));
        } catch (e) {
          emit(const AuthFailure("unexpected error occurred"));
        }
      }
    });
    // Add this handler inside your AuthBloc constructor after other handlers
    on<UserSignInWithGoogle>((e, emit) async {
      emit(const AuthLoading(loadingType: AuthLoadingType.google));
      try {
        await _repo.signInWithGoogle();
        // No need to emit AuthAuthenticated here as the stream will handle it
      } on AuthException catch (err) {
        emit(AuthFailure(err.message));
      } catch (e) {
        if (e.toString().contains('popup_closed_by_user') ||
            e.toString().contains('Sign in was canceled by user') ||
            e.toString().contains('cancelled')) {
          // Return to initial/unauthenticated state when user cancels
          emit(AuthUnauthenticated());
        } else {
          emit(const AuthFailure("Failed to sign in with Google"));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }
}