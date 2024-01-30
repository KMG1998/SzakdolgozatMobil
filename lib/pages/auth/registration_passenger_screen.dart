import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';

class RegistrationPassengerScreen extends StatelessWidget {
  RegistrationPassengerScreen({super.key});

  TextEditingController usernameInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

  TextEditingController passwordInput2Controller = TextEditingController();

  TextEditingController passwordInput3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1),
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
                SizedBox(height: 111.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 339.v),
                      child: Column(
                        children: [
                          Text(
                            "E-mail",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 7.v),
                          _buildUsernameInput(context),
                          SizedBox(height: 31.v),
                          Text(
                            "Név",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 7.v),
                          _buildPasswordInput(context),
                          SizedBox(height: 31.v),
                          Text(
                            "Jelszó",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 7.v),
                          _buildPasswordInput2(context),
                          SizedBox(height: 34.v),
                          Text(
                            "Jelszó ellenőrzés",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 4.v),
                          _buildPasswordInput3(context),
                          SizedBox(height: 77.v),
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
  Widget _buildUsernameInput(BuildContext context) {
    return CustomTextFormField(
      width: 351.h,
      controller: usernameInputController,
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
  Widget _buildPasswordInput2(BuildContext context) {
    return CustomTextFormField(
      width: 351.h,
      controller: passwordInput2Controller,
    );
  }

  /// Section Widget
  Widget _buildPasswordInput3(BuildContext context) {
    return CustomTextFormField(
      width: 351.h,
      controller: passwordInput3Controller,
      textInputAction: TextInputAction.done,
    );
  }

  /// Section Widget
  Widget _buildRegistrationButton(BuildContext context) {
    return CustomOutlinedButton(
      height: 28.v,
      width: 311.h,
      text: "Regisztráció",
      buttonStyle: CustomButtonStyles.outlineBlack,
      buttonTextStyle: theme.textTheme.bodyMedium!,
    );
  }
}
