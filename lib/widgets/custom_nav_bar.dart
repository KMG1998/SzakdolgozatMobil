import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.gen.dart';
import 'package:szakdolgozat_magantaxi_mobil/routes/app_routes.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/app_decoration.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';

class CustomNavBar extends StatelessWidget {
  final int activeNum;

  const CustomNavBar({super.key, required this.activeNum});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black,width: 2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.passengerHistoryPage);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.circleBorder15,
                  color: activeNum == 0 ? appTheme.blue10001 : Colors.transparent),
              padding: EdgeInsets.all(5),
              width: 55,
              height: 55,
              child: SvgPicture.asset(
                Assets.lib.assets.images.imgClock.keyName,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.passengerDashboardPage);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.circleBorder15,
                  color: activeNum == 1 ? appTheme.blue10001 : Colors.transparent),
              padding: EdgeInsets.all(5),
              width: 55,
              height: 55,
              child: SvgPicture.asset(Assets.lib.assets.images.imgHome.keyName),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.passengerProfilePage);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.circleBorder15,
                  color: activeNum == 2 ? appTheme.blue10001 : Colors.transparent),
              width: 55,
              height: 55,
              padding: EdgeInsets.all(5),
              child: SvgPicture.asset(Assets.lib.assets.images.profileButton.keyName),
            ),
          ),
        ],
      ),
    );
  }
}
