import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.dart';


class PassengerDashboardPage extends StatelessWidget {
  const PassengerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
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
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 1.v),
            decoration:
                AppDecoration.gradientPrimaryContainerToOnSecondaryContainer,
            child: Column(
              children: [
                SizedBox(height: 272.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildPassengerDashboard(context),
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
  Widget _buildPassengerDashboard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.v),
      child: Column(
        children: [
          Container(
            height: 168.adaptSize,
            width: 168.adaptSize,
            padding: EdgeInsets.all(29.h),
            decoration: AppDecoration.outlineBlack900.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder84,
            ),
            child: GestureDetector(
              onTap: () => {

              },
              child: CustomImageView(
                imagePath: Assets.imagesNewFuvarButton,
                height: 108.adaptSize,
                width: 108.adaptSize,
                alignment: Alignment.center,
              ),
            ),
          ),
          SizedBox(height: 30.v),
          Text(
            "Új foglalás",
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
