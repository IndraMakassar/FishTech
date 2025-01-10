import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fishtech/repository/authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<UserSignUp>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse user = await repository.signUpWithEmail(
          event.email,
          event.password,
        );
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<UserSignIn>((event, emit) async {
      emit(AuthLoading());
      try {
        final AuthResponse user = await repository.signInWithEmail(
          event.email,
          event.password,
        );
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<UserSignOut>((event, emit) async {
      emit(AuthLoading());
      try {
        repository.signOut();
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
