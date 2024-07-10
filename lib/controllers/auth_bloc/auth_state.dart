part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignIn extends AuthState {
  final User user;

  AuthSignIn({required this.user});
}

final class AuthSignOut extends AuthState {}

final class AuthError extends AuthState {
  final String error;

  AuthError({required this.error});
}
