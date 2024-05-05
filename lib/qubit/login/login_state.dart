part of 'login_cubit.dart';

@immutable
class LoginState {
  final bool isLoading;
  final bool hasError;
  User? user;
  final String? errorMessage;

  LoginState({
    required this.isLoading,
    required this.hasError,
    this.user,
    this.errorMessage,
  });

  LoginState copyWith({isLoading, hasError, user ,errorMessage =""}) {
    return LoginState(
        isLoading: isLoading,
        hasError: hasError,
        errorMessage: errorMessage,
        user: user);
  }
}
