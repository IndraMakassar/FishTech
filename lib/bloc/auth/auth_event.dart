part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class UserSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const UserSignUp({required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class UserSignIn extends AuthEvent {
  final String email;
  final String password;

  const UserSignIn({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class UserSignOut extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class UserCheckedLogIn extends AuthEvent {
  final Session session;

  const UserCheckedLogIn(this.session);

  @override
  List<Object?> get props => [];

}