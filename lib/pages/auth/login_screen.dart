import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/validators.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/login/login_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';

import '../../generated/assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                SizedBox(height: 23.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 164.v),
                      child: Form(
                        key: context.read<LoginCubit>().formKey,
                        child: Column(
                          children: [
                            CustomImageView(
                              imagePath: Assets.imagesImgMagantaxiLogo1,
                              height: 319.adaptSize,
                              width: 319.adaptSize,
                            ),
                            SizedBox(height: 53.v),
                            Text(
                              "E-mail",
                              style: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 7.v),
                            CustomTextFormField(
                              width: 351.v,
                              controller: context.read<LoginCubit>().emailInputController,
                              validator: (email) => Validators.emailValidator(email),
                              focusNode: context.read<LoginCubit>().emailFocus,
                              autofocus: false,
                            ),
                            SizedBox(height: 31.v),
                            Text(
                              "Jelszó",
                              style: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 7.v),
                            CustomTextFormField(
                              width: 351.v,
                              controller: context.read<LoginCubit>().passwordInputController,
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              autoCorrect: false,
                              enableSuggestions: false,
                              focusNode: context.read<LoginCubit>().passwordFocus,
                              validator: (password) => Validators.passwordValidator(password),
                              autofocus: false,
                            ),
                            SizedBox(height: 32.v),
                            _loginButton(),
                            SizedBox(height: 52.v),
                            Text(
                              "Elfelejtett jelszó",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            SizedBox(height: 56.v),
                            _registerButton(context),
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

  _registerButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.registrationPrecondScreen);
      },
      child: Text(
        "Regisztráció",
        style: theme.textTheme.bodyMedium,
      ),
    );
  }

  _loginButton() {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.user != null) {
          if (state.user!.typeId == 5) {
            Navigator.pushNamed(context, AppRoutes.passengerDashboardPage);
          } else {
            Navigator.pushNamed(context, AppRoutes.driverDashboardScreen);
          }
        }
        if (state.hasError) {
          Fluttertoast.showToast(
              msg: "Invalid email or password!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        if (!state.isLoading) {
          return CustomOutlinedButton(
            height: 28,
            width: 269,
            text: "Belépés",
            buttonStyle: CustomButtonStyles.outlineBlack,
            buttonTextStyle: theme.textTheme.bodyMedium!,
            onPressed: () async {
              await context.read<LoginCubit>().login();
            },
          );
        } else {
          return const SizedBox(
            width: 50,
            height: 50,
            child: LoadingIndicator(
              indicatorType: Indicator.ballClipRotatePulse,
              colors: [Colors.black],
            ),
          );
        }
      },
    );
  }
}
