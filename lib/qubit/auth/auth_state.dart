part of 'auth_cubit.dart';

@immutable
class AuthState {}

class AuthInit extends AuthState {}

class AuthInProgress extends AuthState {}

class AuthSuccess extends AuthState {
  final User userData;

  AuthSuccess({required this.userData});
}

class AuthFail extends AuthState{
  final Object error;

  AuthFail(this.error);
}

class PasswordResetInProgress extends AuthState {}
class PasswordResetFail extends AuthState {
  final String? message;
  PasswordResetFail(this.message);
}
class PasswordResetSuccess extends AuthState {}
