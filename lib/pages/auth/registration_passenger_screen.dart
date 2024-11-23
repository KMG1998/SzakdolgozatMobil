
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/User.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/userService.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';

class RegistrationPassengerScreen extends StatefulWidget {
  const RegistrationPassengerScreen({super.key});

  @override
  State<RegistrationPassengerScreen> createState() => _RegistrationPassengerScreenState();
}

class _RegistrationPassengerScreenState extends State<RegistrationPassengerScreen> {
  TextEditingController emailInputController = TextEditingController();

  TextEditingController nameInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

  TextEditingController passwordAgainInputController = TextEditingController();

  static UserService userService = UserService();

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
                      padding: EdgeInsets.only(bottom: 339.w),
                      child: Column(
                        children: [
                          Text(
                            "E-mail",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 7.w),
                          _buildEmailInput(context),
                          SizedBox(height: 31.w),
                          Text(
                            "Név",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 7.w),
                          _buildNameInput(context),
                          SizedBox(height: 31.w),
                          Text(
                            "Jelszó",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 7.w),
                          _buildPasswordInput(context),
                          SizedBox(height: 34.w),
                          Text(
                            "Jelszó ellenőrzés",
                            style: theme.textTheme.bodyMedium,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailInput(BuildContext context) {
    return CustomTextFormField(
      width: 351.h,
      controller: emailInputController,
    );
  }

  /// Section Widget
  Widget _buildNameInput(BuildContext context) {
    return CustomTextFormField(
      width: 351.h,
      controller: nameInputController,
    );
  }

  /// Section Widget
  Widget _buildPasswordInput(BuildContext context) {
    return CustomTextFormField(
      width: 351.h,
      controller: passwordInputController,
    );
  }

  /// Section Widget
  Widget _buildPasswordAgainInput(BuildContext context) {
    return CustomTextFormField(
      width: 351.h,
      controller: passwordAgainInputController,
      textInputAction: TextInputAction.done,
    );
  }

  /// Section Widget
  Widget _buildRegistrationButton(BuildContext context) {
    return CustomOutlinedButton(
      height: 40.h,
      width: 311.w,
      text: "Regisztráció",
      buttonStyle: CustomButtonStyles.outlineBlack,
      buttonTextStyle: theme.textTheme.bodyMedium!,
      onPressed: () async {
        userService
            .createPassenger(emailInputController.text, passwordInputController.text, nameInputController.text)
            .then((newUser) {
          debugPrint('success:$newUser');
          if () {
            navigatorKey.currentState?.pushNamed(AppRoutes.loginScreen);
            return;
          }
        });
      },
    );
  }
}
