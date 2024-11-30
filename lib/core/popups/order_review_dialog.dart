import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/order_review.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/order/order_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/app_decoration.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';

class OrderReviewDialog extends StatefulWidget {
  const OrderReviewDialog({super.key});

  @override
  State<OrderReviewDialog> createState() => _OrderReviewDialogState();
}

class _OrderReviewDialogState extends State<OrderReviewDialog> {
  double reviewScore = 3;
  final TextEditingController reviewTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return Container(
            width: 550.w,
            height: 370.h,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.circleBorder15,
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sofőr értékelés',
                  style: theme.textTheme.headlineLarge,
                ),
                SizedBox(height: 20),
                Text(
                  'Kérjük, értékelje a sofőrt!',
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  reviewScore.toString(),
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 500.w,
                  child: Slider(
                      value: reviewScore,
                      activeColor: ThemeHelper().themeColor().blue10001,
                      divisions: 8,
                      label: reviewScore.toString(),
                      min: 1,
                      max: 5,
                      onChanged: (val) {
                        setState(() {
                          reviewScore = val;
                        });
                      }),
                ),
                SizedBox(
                  height: 80,
                  width: 500.w,
                  child: CustomTextFormField(
                    controller: reviewTextController,
                    hintText: 'Szöveges értékelés',
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomOutlinedButton(
                      text: 'Most nem',
                      width: 200.w,
                      onPressed: () => {Navigator.pop(context)},
                    ),
                    Expanded(child: SizedBox()),
                    CustomOutlinedButton(
                      text: 'Értékelés',
                      width: 200.w,
                      onPressed: () => {
                        Navigator.pop(
                            context,
                            OrderReview(
                              score: reviewScore,
                              reviewText: reviewTextController.text,
                            ))
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
