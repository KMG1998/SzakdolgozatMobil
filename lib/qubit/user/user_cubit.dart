import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/toast_wrapper.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/user.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/user_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInit());

  final _logger = Logger();

  void getUserData() async {
    try {
      emit(UserLoading());
      final userData = await getIt.get<UserService>().getOwnData();
      emit(UserLoaded(userData: userData));
    }catch(e){
      _logger.e(e);
      emit(UserError(errorMessage: 'Ismeretlen hiba'));
    }
  }

  void changeName (String newName) async{
    emit(UserLoading());
    final success = await getIt.get<UserService>().changeName(newName);
    if(success){
      ToastWrapper.showSuccessToast(message: 'Sikeres mentés');
      emit(UserInit());
      return;
    }
    ToastWrapper.showErrorToast(message: 'Sikertelen mentés');
    emit(UserInit());
  }
}
