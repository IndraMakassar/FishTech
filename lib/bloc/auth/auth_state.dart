part of 'auth_bloc.dart';

enum AuthLoadingType {
  email,
  google,
  profile
}

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}


final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {
  final AuthLoadingType loadingType;

  const AuthLoading({required this.loadingType});

  @override
  List<Object?> get props => [loadingType];

}

final class AuthAuthenticated extends AuthState {
  final Session session;

  const AuthAuthenticated(this.session);

  @override
  List<Object?> get props => [session];
}

final class AuthUnauthenticated extends AuthState {

}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
