import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/auth/registration_passenger_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';

class RegistrationPrecondScreen extends StatelessWidget {
  const RegistrationPrecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
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
                SizedBox(height: 200.v),
                Expanded(
                  child: _buildRegistrationButtons(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRegistrationButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 53.h,
        right: 53.h,
        bottom: 383.v,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 85.h,
        vertical: 65.v,
      ),
      decoration: AppDecoration.outlineBlack9007.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 8.v),
          CustomOutlinedButton(
            text: "utas regisztráció",
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegistrationPassengerScreen())),
          ),
          SizedBox(height: 73.v),
          CustomOutlinedButton(
            text: "sofőr regisztáció",
          ),
        ],
      ),
    );
  }
}
