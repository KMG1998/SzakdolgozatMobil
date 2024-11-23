import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/User.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState(userData: null));
}
