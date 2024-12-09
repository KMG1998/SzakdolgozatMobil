import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/toast_wrapper.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/validators.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
import 'package:szakdolgozat_magantaxi_mobil/routes/app_routes.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/user_service.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/custom_button_style.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';

class RegistrationPassengerScreen extends StatefulWidget {
  const RegistrationPassengerScreen({super.key});

  @override
  State<RegistrationPassengerScreen> createState() => _RegistrationPassengerScreenState();
}

class _RegistrationPassengerScreenState extends State<RegistrationPassengerScreen> {
  final TextEditingController emailInputController = TextEditingController();

  final TextEditingController nameInputController = TextEditingController();

  final TextEditingController passwordInputController = TextEditingController();

  final TextEditingController passwordAgainInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.5, 0),
              end: const Alignment(0.5, 1),
              colors: [
                theme.colorScheme.primaryContainer,
                appTheme.blue100,
                theme.colorScheme.onSecondaryContainer,
              ],
            ),
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(height: 111.w),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 339.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              "E-mail",
                              style: theme.textTheme.titleLarge,
                            ),
                            SizedBox(height: 7.w),
                            _buildEmailInput(context),
                            SizedBox(height: 31.w),
                            Text(
                              "Név",
                              style: theme.textTheme.titleLarge,
                            ),
                            SizedBox(height: 7.w),
                            _buildNameInput(context),
                            SizedBox(height: 31.w),
                            Text(
                              "Jelszó",
                              style: theme.textTheme.titleLarge,
                            ),
                            SizedBox(height: 7.w),
                            _buildPasswordInput(context),
                            SizedBox(height: 34.w),
                            Text(
                              "Jelszó ismét",
                              style: theme.textTheme.titleLarge,
                            ),
                            SizedBox(height: 4.w),
                            _buildPasswordAgainInput(context),
                            SizedBox(height: 77.w),
                            _buildRegistrationButton(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  dispose(){
    super.dispose();
  }

  Widget _buildEmailInput(BuildContext context) {
    return CustomTextFormField(
      width: 351.h,
      controller: emailInputController,
    );
  }

  Widget _buildNameInput(BuildContext context) {
    return CustomTextFormField(
      width: 351.h,
      controller: nameInputController,
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return CustomTextFormField(
      width: 351.h,
      controller: passwordInputController,
      validator: (password) => Validators.passwordValidator(password),
      obscureText: true,
    );
  }

  Widget _buildPasswordAgainInput(BuildContext context) {
    return CustomTextFormField(
        width: 351.h,
        controller: passwordAgainInputController,
        textInputAction: TextInputAction.done,
        obscureText: true,
        validator: (passwordAgain) => Validators.passwordAgainValidator(passwordInputController.text, passwordAgain));
  }

  Widget _buildRegistrationButton(BuildContext context) {
    return CustomOutlinedButton(
      height: 40.h,
      width: 311.w,
      text: "Regisztráció",
      buttonStyle: CustomButtonStyles.outlineBlack,
      buttonTextStyle: theme.textTheme.bodyLarge,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          getIt
              .get<UserService>()
              .createPassenger(
                emailInputController.text,
                passwordInputController.text,
                nameInputController.text,
              )
              .then((success) {
            if (success) {
              navigatorKey.currentState?.pushReplacementNamed(AppRoutes.loginScreen);
              return;
            }
            ToastWrapper.showErrorToast(message: 'Sikertelen regisztráció');
          });
        }
      },
    );
  }
}
