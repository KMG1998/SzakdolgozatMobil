import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/User.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/userService.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';

import '../../generated/assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController eamilInputController = TextEditingController();

  TextEditingController passwordInputController = TextEditingController();

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
                            width: 351.h,
                            controller: eamilInputController,
                          ),
                          SizedBox(height: 31.v),
                          Text(
                            "Jelszó",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 7.v),
                          CustomTextFormField(
                            width: 351.h,
                            controller: passwordInputController,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(height: 32.v),
                          CustomOutlinedButton(
                            height: 28.v,
                            width: 269.h,
                            text: "Belépés",
                            buttonStyle: CustomButtonStyles.outlineBlack,
                            buttonTextStyle: theme.textTheme.bodyMedium!,
                            onPressed: () async {
                              User user = await UserService().logUserIn(eamilInputController.text, passwordInputController.text);
                              if(user.typeId == 5) {
                                Navigator.pushNamed(
                                    context, AppRoutes.passengerDashboardPage);
                              }else{
                                Navigator.pushNamed(
                                    context, AppRoutes.driverDashboardScreen);
                              }
                            },
                          ),
                          SizedBox(height: 52.v),
                          Text(
                            "Elfelejtett jelszó",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(height: 56.v),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                  AppRoutes.registrationPrecondScreen);
                            },
                            child: Text(
                              "Regisztráció",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
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
}
