import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/image_constant.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_radio_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';

class NewReserveReactPopupDialog extends StatelessWidget {
  NewReserveReactPopupDialog({Key? key})
      : super(
          key: key,
        );

  TextEditingController bookingDetailsEditTextController =
      TextEditingController();

  String radioGroup = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          left: 53.h,
          right: 53.h,
          bottom: 161.v,
        ),
        padding: EdgeInsets.symmetric(vertical: 11.v),
        decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBookingDetailsEditText(context),
            SizedBox(height: 44.v),
            Padding(
              padding: EdgeInsets.only(
                left: 39.h,
                right: 165.h,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(3.h),
                    decoration: AppDecoration.outlineBlack9008.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder15,
                    ),
                    child: Container(
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                      decoration: BoxDecoration(
                        color: appTheme.black900,
                        borderRadius: BorderRadius.circular(
                          10.h,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.h,
                      bottom: 2.v,
                    ),
                    child: Text(
                      "azonnali",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  Spacer(),
                  _buildOrderTypeSelectRadio(context),
                ],
              ),
            ),
            SizedBox(height: 38.v),
            Padding(
              padding: EdgeInsets.only(left: 25.h),
              child: Text(
                "utas értékelése:",
                style: theme.textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 28.v),
            Padding(
              padding: EdgeInsets.only(left: 25.h),
              child: Text(
                "Indulási cím:",
                style: theme.textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 30.v),
            Padding(
              padding: EdgeInsets.only(left: 25.h),
              child: Text(
                "Érkezési cím:",
                style: theme.textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 28.v),
            Padding(
              padding: EdgeInsets.only(
                left: 25.h,
                right: 51.h,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.v,
                      bottom: 12.v,
                    ),
                    child: Text(
                      "indulási dátum: ",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  _buildStartDateBlockButton(context),
                ],
              ),
            ),
            SizedBox(height: 28.v),
            Padding(
              padding: EdgeInsets.only(
                left: 25.h,
                right: 51.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.v,
                      bottom: 12.v,
                    ),
                    child: Text(
                      "indulási idő: ",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  _buildStartTimeBlockButton(context),
                ],
              ),
            ),
            SizedBox(height: 25.v),
            Padding(
              padding: EdgeInsets.only(
                left: 25.h,
                right: 51.h,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 12.v,
                      bottom: 10.v,
                    ),
                    child: Text(
                      "személyek száma:",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  _buildStartTimeBlockButton1(context),
                ],
              ),
            ),
            SizedBox(height: 25.v),
            CustomImageView(
              imagePath: ImageConstant.imgResponseButtons,
              height: 78.v,
              width: 347.h,
              alignment: Alignment.center,
            ),
            SizedBox(height: 20.v),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBookingDetailsEditText(BuildContext context) {
    return CustomTextFormField(
      controller: bookingDetailsEditTextController,
      hintText: "új foglalás adatai",
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.h),
      borderDecoration: TextFormFieldStyleHelper.underLineBlack,
      filled: false,
    );
  }

  /// Section Widget
  Widget _buildOrderTypeSelectRadio(BuildContext context) {
    return CustomRadioButton(
      text: "előjegyzés",
      value: "előjegyzés",
      groupValue: radioGroup,
      padding: EdgeInsets.symmetric(vertical: 1.v),
      onChange: (value) {
        radioGroup = value;
      },
    );
  }

  /// Section Widget
  Widget _buildStartDateBlockButton(BuildContext context) {
    return CustomOutlinedButton(
      width: 278.h,
      text: "2024.01.01",
      margin: EdgeInsets.only(left: 35.h),
      buttonStyle: CustomButtonStyles.outlineBlackTL202,
    );
  }

  /// Section Widget
  Widget _buildStartTimeBlockButton(BuildContext context) {
    return CustomOutlinedButton(
      width: 278.h,
      text: "15:00",
      buttonStyle: CustomButtonStyles.outlineBlackTL202,
    );
  }

  /// Section Widget
  Widget _buildStartTimeBlockButton1(BuildContext context) {
    return CustomOutlinedButton(
      width: 278.h,
      text: "2",
      margin: EdgeInsets.only(left: 23.h),
      buttonStyle: CustomButtonStyles.outlineBlackTL202,
    );
  }
}
