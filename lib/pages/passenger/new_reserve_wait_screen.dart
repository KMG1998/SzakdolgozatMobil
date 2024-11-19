import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.dart';

class NewReserveWaitScreen extends StatelessWidget {
  NewReserveWaitScreen({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

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
                SizedBox(height: 138.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Kérjük várjon a jóváhagyásra!",
                          style: theme.textTheme.headlineLarge,
                        ),
                        SizedBox(height: 242.v),
                        CustomImageView(
                          imagePath: Assets.imagesImgHome,
                          height: 154.v,
                          width: 146.h,
                        ),
                        SizedBox(height: 269.v),
                        CustomImageView(
                          imagePath: Assets.imagesImgHome,
                          height: 77.adaptSize,
                          width: 77.adaptSize,
                        ),
                      ],
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
