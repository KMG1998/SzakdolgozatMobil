import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnSecondaryContainer => BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
      );

  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );

  // Gradient decorations
  static BoxDecoration get gradientPrimaryContainerToOnSecondaryContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            theme.colorScheme.primaryContainer,
            appTheme.blue100,
            theme.colorScheme.onSecondaryContainer,
          ],
        ),
      );
}

class BorderRadiusStyle {
  static BorderRadius get circleBorder15 => BorderRadius.circular(
        15.h,
      );

  static BorderRadius get customBorderBL20 => BorderRadius.vertical(
        bottom: Radius.circular(20.h),
      );

  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );

  static BorderRadius get roundedBorderTL20 => BorderRadius.vertical(
    top: Radius.circular(20.h),
  );
}
