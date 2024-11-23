part of 'user_cubit.dart';

@immutable
class UserState {
  final User? userData;

  const UserState({
    required this.userData,
  });

  UserState copyWith({userData}) {
    return UserState(
      userData: userData,
    );
  }
}
