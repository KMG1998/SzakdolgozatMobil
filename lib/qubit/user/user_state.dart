part of 'user_cubit.dart';

@immutable
class UserState {
  final User? userData;
  final Position? currentPos;

  const UserState({
    required this.userData,
    required this.currentPos,
  });

  UserState copyWith({userData, currentPos}) {
    return UserState(
      userData: userData,
      currentPos: currentPos,
    );
  }
}
