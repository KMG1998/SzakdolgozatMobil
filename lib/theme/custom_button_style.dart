import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class CustomButtonStyles {
  // Outline button style
  static ButtonStyle get outlineBlack => OutlinedButton.styleFrom(
    backgroundColor: theme.colorScheme.onSecondaryContainer,
    side: BorderSide(
      color: appTheme.black,
      width: 2,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.h),
    ),
  );
  static ButtonStyle get outlineRed=> OutlinedButton.styleFrom(
    backgroundColor: theme.colorScheme.onSecondaryContainer,
    side: BorderSide(
      color: Colors.redAccent,
      width: 2,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.h),
    ),
  );

  static ButtonStyle get outlineGreen=> OutlinedButton.styleFrom(
    backgroundColor: theme.colorScheme.onSecondaryContainer,
    side: BorderSide(
      color: Colors.green,
      width: 2,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.h),
    ),
  );

  // text button style
  static ButtonStyle get none => ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    elevation: WidgetStateProperty.all<double>(0),
  );
}
