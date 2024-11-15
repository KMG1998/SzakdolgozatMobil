import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/userService.dart';

import '../../models/User.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(isLoading: false, hasError: false));

  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  final logger = Logger();

  Future<void> login() async {
    if(!formKey.currentState!.validate()){
      return;
    }
    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      user: null,
    ));
    try {
      User? userData = await getIt.get<UserService>().logUserIn(emailInputController.text, passwordInputController.text);
      emit(state.copyWith(
        isLoading: false,
        hasError: false,
        user: userData,
      ));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        user: null,
        errorMessage: e.toString(),
      ));
    }
  }
}
