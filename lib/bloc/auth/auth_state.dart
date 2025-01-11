part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];

}

final class AuthSuccess extends AuthState {
  final AuthResponse res;

  const AuthSuccess(this.res);

  @override
  List<Object?> get props => [res];

}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];

}