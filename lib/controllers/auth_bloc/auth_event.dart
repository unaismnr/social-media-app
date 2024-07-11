part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  AuthSignUpEvent({
    required this.email,
    required this.password,
    required this.username,
  });
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

class AuthSignOutEvent extends AuthEvent {}

class AuthSendResetEmail extends AuthEvent {
  final String email;

  AuthSendResetEmail({
    required this.email,
  });
}
