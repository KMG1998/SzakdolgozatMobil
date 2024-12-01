part of 'user_cubit.dart';

@immutable
class UserState {
  const UserState._();
}

class UserInit extends UserState{
  const UserInit() : super._();
}

class UserLoading extends UserState{
  const UserLoading() : super._();
}

class UserLoaded extends UserState{
  final User userData;

  const UserLoaded({required this.userData}) : super._();
}

class UserError extends UserState{
  final String errorMessage;
  const UserError({required this.errorMessage}) : super._();
}