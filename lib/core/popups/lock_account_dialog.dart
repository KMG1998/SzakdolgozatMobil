import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/user/user_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/app_decoration.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/custom_button_style.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';

class LockAccountDialog extends StatefulWidget {
  const LockAccountDialog({super.key});

  @override
  State<LockAccountDialog> createState() => _LockAccountDialogState();
}

class _LockAccountDialogState extends State<LockAccountDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 550.w,
        height: 370.h,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.circleBorder15,
          color: Colors.white,
        ),
        child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          if (state is UserLocked) {
            return Center(
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [Colors.black],
              ),
            );
          }
          return Column(
            children: [
              Text(
                'Profil zárolás',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(height: 20),
              Text(
                'Amennyiben zárolja a profilját, egy éven belül törölni fogjuk rendszerünkből.'
                ' Ez a művelet végleges, később nem fog tudni hozzáférni az alkalmazáshoz a jelenlegi e-mail'
                'címhez tartozó profil törléséig!',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Expanded(child: SizedBox()),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomOutlinedButton(
                    text: 'Mégse',
                    width: 200.w,
                    onPressed: () => {Navigator.pop(context)},
                  ),
                  Expanded(child: SizedBox()),
                  CustomOutlinedButton(
                    text: 'Zárolás',
                    width: 200.w,
                    buttonStyle: CustomButtonStyles.outlineRed,
                    onPressed: () => {
                      context.read<UserCubit>().lockProfile()
                    },
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
