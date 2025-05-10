import 'package:equatable/equatable.dart';
import 'package:fishtech/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<UserCheckedLogIn>((event, emit) {
      emit(AuthAuthenticated(event.session));
    });

    on<UserSignUp>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse user =
            await repository.signUpWithEmail(event.name, event.email, event.password);
        emit(AuthAuthenticated(user.session!));
      } on AuthException catch (e) {
        emit(AuthFailure(e.message));
      } catch (e) {
        emit(AuthFailure("enexpected error occurred"));
      }
    });

    on<UserSignIn>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse user = await repository.signInWithEmail(
          event.email,
          event.password,
        );
        emit(AuthAuthenticated(user.session!));
      } on AuthException catch (e) {
        emit(AuthFailure(e.message));
      } catch (e) {
        emit(AuthFailure("enexpected error occurred"));
      }
    });

    on<UserSignOut>((event, emit) async {
      emit(AuthLoading());
      try {
        repository.signOut();
        emit(AuthInitial());
      } on AuthException catch (e) {
        emit(AuthFailure(e.message));
      } catch (e) {
        emit(AuthFailure("enexpected error occurred"));
      }
    });

    on<UserChangeName>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse user = await repository.changeName(event.newName);
        emit(AuthAuthenticated(user.session!));
      } on AuthException catch (e) {
        emit(AuthFailure(e.message));
      } catch (e) {
        emit(AuthFailure("enexpected error occurred"));
      }
    });


  }
}
