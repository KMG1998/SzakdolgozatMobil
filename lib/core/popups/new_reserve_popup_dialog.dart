import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_radio_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';


class NewReservePopupDialog extends StatelessWidget {
  NewReservePopupDialog({Key? key})
      : super(
          key: key,
        );

  TextEditingController bookingDetailsController = TextEditingController();

  String radioGroup = "";

  List<String> radioList = ["lbl_azonnali", "lbl_el_jegyz_s"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          left: 53.h,
          right: 53.h,
          bottom: 116.v,
        ),
        padding: EdgeInsets.symmetric(vertical: 11.v),
        decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              controller: bookingDetailsController,
              hintText: "új foglalás adatai",
              textInputAction: TextInputAction.done,
              contentPadding: EdgeInsets.symmetric(horizontal: 15.h),
              borderDecoration: TextFormFieldStyleHelper.underLineBlack,
              filled: false,
            ),
            SizedBox(height: 44.v),
            _buildOrderTypeSelect(context),
            SizedBox(height: 40.v),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 104.h,
                  vertical: 8.v,
                ),
                decoration: AppDecoration.outlineBlack9004.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 3.v),
                    Text(
                      "indulási cím kiválasztása",
                      style: theme.textTheme.titleLarge!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 23.v),
            Padding(
              padding: EdgeInsets.only(left: 25.h),
              child: Text(
                "Indulási cím:",
                style: theme.textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 60.v),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(
                  left: 27.h,
                  right: 23.h,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 104.h,
                  vertical: 8.v,
                ),
                decoration: AppDecoration.outlineBlack9004.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 3.v),
                    Text(
                      "érkezési cím kiválasztása",
                      style: theme.textTheme.titleLarge!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 22.v),
            Padding(
              padding: EdgeInsets.only(left: 27.h),
              child: Text(
                "Érkezési cím:",
                style: theme.textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 63.v),
            Padding(
              padding: EdgeInsets.only(
                left: 27.h,
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
                  CustomOutlinedButton(
                    width: 278.h,
                    text: "2",
                    margin: EdgeInsets.only(left: 23.h),
                    buttonStyle: CustomButtonStyles.outlineBlackTL202,
                  ),
                ],
              ),
            ),
            SizedBox(height: 165.v),
            CustomOutlinedButton(
              text: "tovább",
              margin: EdgeInsets.symmetric(horizontal: 25.h),
              alignment: Alignment.center,
            ),
            SizedBox(height: 23.v),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildOrderTypeSelect(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 39.h,
        right: 165.h,
      ),
      child: Row(
        children: [
          CustomRadioButton(
            text: "azonnali",
            value: radioList[0],
            groupValue: radioGroup,
            padding: EdgeInsets.symmetric(vertical: 1.v),
            onChange: (value) {
              radioGroup = value;
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 56.h),
            child: CustomRadioButton(
              text: "előjegyzés",
              value: radioList[1],
              groupValue: radioGroup,
              padding: EdgeInsets.symmetric(vertical: 1.v),
              onChange: (value) {
                radioGroup = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
