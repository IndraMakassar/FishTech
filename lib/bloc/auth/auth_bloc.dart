import 'package:equatable/equatable.dart';
import 'package:fishtech/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<UserCheckedLogIn>((event, emit) async {
      emit(AuthLoading());
      try {
        final session = await _repository.checkSession();
        if (session != null) {
          emit(AuthSuccess(session));
        } else {
          emit(const AuthFailure("No active session"));
        }
      } catch (e) {
        emit(const AuthFailure("Failed to check session"));
      }
    });

    on<UserSignUp>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse user = await _repository.signUpWithEmail(
            event.name, event.email, event.password);
        emit(AuthSuccess(user.session!));
      } on AuthException catch (e) {
        emit(AuthFailure(e.message));
      } catch (e) {
        emit(const AuthFailure("enexpected error occurred"));
      }
    });

    on<UserSignIn>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse user = await _repository.signInWithEmail(
          event.email,
          event.password,
        );
        emit(AuthSuccess(user.session!));
      } on AuthException catch (e) {
        emit(AuthFailure(e.message));
      } catch (e) {
        emit(const AuthFailure("enexpected error occurred"));
      }
    });

    on<UserSignOut>((event, emit) async {
      emit(AuthLoading());
      try {
        _repository.signOut();
        emit(AuthInitial());
      } on AuthException catch (e) {
        emit(AuthFailure(e.message));
      } catch (e) {
        emit(const AuthFailure("enexpected error occurred"));
      }
    });

    on<UserChangeName>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse user = await _repository.changeName(event.newName);
        emit(AuthSuccess(user.session!));
      } on AuthException catch (e) {
        emit(AuthFailure(e.message));
      } catch (e) {
        emit(const AuthFailure("enexpected error occurred"));
      }
    });
  }
}
