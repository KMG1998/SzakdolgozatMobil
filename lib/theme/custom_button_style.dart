import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:flutter/material.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Outline button style
  static ButtonStyle get outlineBlack => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        side: BorderSide(
          color: appTheme.black900,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );
  static ButtonStyle get outlineBlackTL18 => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        side: BorderSide(
          color: appTheme.black900,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.h),
        ),
      );
  static ButtonStyle get outlineBlackTL20 => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        side: BorderSide(
          color: appTheme.black900,
          width: 3,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              20.h,
            ),
          ),
        ),
      );
  static ButtonStyle get outlineBlackTL202 => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        side: BorderSide(
          color: appTheme.black900,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
      );
  static ButtonStyle get outlineBlack1 => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        side: BorderSide(
          color: appTheme.black900,
          width: 3,
        ),
        shape: RoundedRectangleBorder(),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        elevation: WidgetStateProperty.all<double>(0),
      );
}
