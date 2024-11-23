import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/userService.dart';

import '../../models/User.dart';

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

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(AuthInProgress());
    try {
      User? userData =
          await getIt.get<UserService>().logUserIn(emailInputController.text, passwordInputController.text);
      emit(AuthSuccess(userData: userData));
    } catch (e) {
      logger.e(e);
      emit(AuthFail(e));
    }
  }

  resetPassword({required String email}) async {
    emit(PasswordResetInProgress());
    try {
      final success = await getIt.get<UserService>().resetPassword(email);
      if (success) {
        emit(PasswordResetSuccess());
        return;
      }
      emit(PasswordResetFail('Unknown error'));
    } catch (e) {
      if (e is DioException) {
        emit(PasswordResetFail(e.message));
      }
    }
  }
}
