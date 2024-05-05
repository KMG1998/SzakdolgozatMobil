import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/userService.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';

class RegistrationPassengerScreen extends StatefulWidget {
  const RegistrationPassengerScreen({super.key});

  @override
  State<RegistrationPassengerScreen> createState() =>
      _RegistrationPassengerScreenState();
}

class _RegistrationPassengerScreenState
    extends State<RegistrationPassengerScreen> {
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
          width: SizeUtils.width,
          height: SizeUtils.height,
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
                          _buildEmailInput(context),
                          SizedBox(height: 31.v),
                          Text(
                            "Név",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 7.v),
                          _buildNameInput(context),
                          SizedBox(height: 31.v),
                          Text(
                            "Jelszó",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 7.v),
                          _buildPasswordInput(context),
                          SizedBox(height: 34.v),
                          Text(
                            "Jelszó ellenőrzés",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 4.v),
                          _buildPasswordAgainInput(context),
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
      height: 28.v,
      width: 311.h,
      text: "Regisztráció",
      buttonStyle: CustomButtonStyles.outlineBlack,
      buttonTextStyle: theme.textTheme.bodyMedium!,
      onPressed: () async {
        userService
            .createPassenger(emailInputController.text,
                passwordInputController.text, nameInputController.text)
            .then(
                (value) => Navigator.pushNamed(context, AppRoutes.loginScreen));
      },
    );
  }
}
