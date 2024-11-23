import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';


class ReserveRejectedPopupDialog extends StatelessWidget {
  const ReserveRejectedPopupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _buildNewReserveBody(context),
    );
  }

  /// Section Widget
  Widget _buildNewReserveBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 53.h,
        right: 53.h,
        bottom: 356.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 30.w,
      ),
      decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "foglalás elutasítva",
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: 45.w),
          Text(
            "Kérjük, válasszon másik járművet!",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 112.w),
          CustomOutlinedButton(
            text: "tovább",
          ),
          SizedBox(height: 9.w),
        ],
      ),
    );
  }
}
