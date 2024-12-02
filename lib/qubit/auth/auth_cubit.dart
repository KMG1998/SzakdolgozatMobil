import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
import 'package:szakdolgozat_magantaxi_mobil/routes/app_routes.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/user_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInit());

  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  final logger = Logger();

  reset() {
    emit(AuthInit());
  }

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(AuthInProgress());
    try {
      bool success = await getIt.get<UserService>().logUserIn(emailInputController.text, passwordInputController.text);
      if (success) {
        emailInputController.value = TextEditingValue();
        passwordInputController.value = TextEditingValue();
        emit(AuthSuccess());
      }
    } catch (e) {
      logger.e(e);
      emit(AuthFail(e));
    }
  }

  void resetPassword({required String email}) async {
    emit(PasswordResetInProgress());
    try {
      final success = await getIt.get<UserService>().resetPassword(email);
      if (success) {
        emit(PasswordResetSuccess());
        return;
      }
      emit(PasswordResetFail('Ismeretlen hiba'));
    } catch (e) {
      if (e is DioException) {
        emit(PasswordResetFail(e.message));
      }
    }
  }

  void changePassword({required String currentPassword, required String newPassword}) async {
    emit(PasswordChangeInProgress());
    final success = await getIt.get<UserService>().changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        );
    if(success){
      logOut();
    }
    emit(PasswordResetFail('Sikertelen jelszó csere'));
  }

  void logOut() async{
    final success = await getIt.get<UserService>().logOut();
    if (success){
      navigatorKey.currentState!.pushReplacementNamed(AppRoutes.loginScreen);
      final secureStorage = getIt.get<FlutterSecureStorage>();
      await secureStorage.delete(key: 'token');
      await secureStorage.delete(key: 'roomId');
      return;
    }
    Fluttertoast.showToast(msg: 'Sikertelen kijelentkezés');
  }
}
