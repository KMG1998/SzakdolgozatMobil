import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';

class RegistrationPrecondScreen extends StatelessWidget {
  const RegistrationPrecondScreen({Key? key})
      : super(
          key: key,
        );

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
                SizedBox(height: 252.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildRegistrationButtons(context),
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
