import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_icon_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';

class NewReserveCarSelectScreen extends StatelessWidget {
  NewReserveCarSelectScreen({Key? key})
      : super(
          key: key,
        );

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
                SizedBox(height: 25.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath: Assets.imagesImgArrowDown,
                          height: 29.v,
                          width: 38.h,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 25.h),
                        ),
                        SizedBox(height: 38.v),
                        CustomOutlinedButton(
                          height: 60.v,
                          text: "elérhető járművek",
                          buttonStyle: CustomButtonStyles.outlineBlack1,
                        ),
                        Column(
                          children: [
                            _buildCarSelection(context),
                            _buildCarDetails(context),
                            _buildCarOptions(context),
                          ],
                        ),
                        SizedBox(height: 108.v),
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

  /// Section Widget
  Widget _buildCarSelection(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.h, 13.v, 14.h, 12.v),
      decoration: AppDecoration.outlineBlack9005,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.v),
                  child: Text(
                    "lorem ipsum",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                CustomIconButton(
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  child: CustomImageView(
                    imagePath: Assets.imagesImgArrowUp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 37.v),
          Padding(
            padding: EdgeInsets.only(right: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "utas ülések száma:",
                      style: theme.textTheme.titleLarge,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.h),
                      child: Text(
                        "4",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 19.v),
                Row(
                  children: [
                    Text(
                      "légkondi:",
                      style: theme.textTheme.titleLarge,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.h),
                      child: Text(
                        "igen",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.v),
                Row(
                  children: [
                    Text(
                      "sofőr értékelése:",
                      style: theme.textTheme.titleLarge,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 27.h),
                      child: Text(
                        "4.2",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 17.v),
                Text(
                  "leírás:",
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: 18.v),
                Container(
                  width: 575.h,
                  margin: EdgeInsets.only(right: 63.h),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac pulvinar sapien, sit amet vestibulum odio. Morbi finibus dolor et tincidunt faucibus.",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 14.v),
                CustomOutlinedButton(
                  text: "jármű kiválasztása",
                  margin: EdgeInsets.only(
                    left: 66.h,
                    right: 55.h,
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 13.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCarDetails(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 13.v,
      ),
      decoration: AppDecoration.outlineBlack9006,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.v),
            child: Text(
              "lorem ipsum",
              style: theme.textTheme.titleLarge,
            ),
          ),
          CustomImageView(
            imagePath: Assets.imagesImgArrowDownBlack900,
            height: 30.adaptSize,
            width: 30.adaptSize,
            margin: EdgeInsets.only(right: 4.h),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCarOptions(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 13.v,
      ),
      decoration: AppDecoration.outlineBlack9006,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.v),
            child: Text(
              "lorem ipsum",
              style: theme.textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 4.h),
            child: CustomIconButton(
              height: 30.adaptSize,
              width: 30.adaptSize,
              decoration: IconButtonStyleHelper.fillBlack,
              child: CustomImageView(
                imagePath:  Assets.imagesImgArrowDownBlack900,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
