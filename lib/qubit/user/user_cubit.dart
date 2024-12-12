import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/toast_wrapper.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/user.dart';
import 'package:szakdolgozat_magantaxi_mobil/routes/app_routes.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/user_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInit());

  void getUserData() async {
    try {
      emit(UserLoading());
      final userData = await getIt.get<UserService>().getOwnData();
      emit(UserLoaded(userData: userData));
    }catch(e){
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

  void lockProfile() async{
      emit(UserLocked());
      final success = await getIt.get<UserService>().lockProfile();
      if(success){
        emit(UserLocked());
        ToastWrapper.showSuccessToast(message: 'Sikeres zárolás');
        await navigatorKey.currentState!.pushReplacementNamed(AppRoutes.loginScreen);
        return;
      }
      ToastWrapper.showErrorToast(message: 'Sikertelen zárolás');
      emit(UserInit());
  }
}
