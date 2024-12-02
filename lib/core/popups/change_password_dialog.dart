import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/toast_wrapper.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/validators.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/auth/auth_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/app_decoration.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/custom_button_style.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';

class ChangePasswordDialog extends StatefulWidget {
  ChangePasswordDialog({super.key});

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _againPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 550.w,
        height: 450.h,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.circleBorder15,
          color: Colors.white,
        ),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is PasswordChangeInProgress) {
              return LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [Colors.black],
              );
            }
            if (state is PasswordChangeFail) {
              ToastWrapper.showErrorToast(message: "Sikertelen művelet!");
            }
            return _changePasswordForm();
          },
        ),
      ),
    );
  }

  _changePasswordForm() {
    return Form(
      key: widget._formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Jelszó megváltoztatása',
            style: theme.textTheme.headlineLarge,
          ),
          SizedBox(height: 20),
          Text(
            'Amennyiben sikeres a jelszó váltás, az alkalmazás ki fogja jelentkeztetni!',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          _inputField(
            labelText: 'Jelenlegi jelszó',
            controller: widget._currentPasswordController,
            validator: (password) => Validators.passwordValidator(password),
          ),
          SizedBox(height: 20),
          _inputField(
            labelText: 'Új jelszó',
            controller: widget._newPasswordController,
            validator: (password) => Validators.passwordValidator(password),
          ),
          SizedBox(height: 20),
          _inputField(
            labelText: 'Új jelszó újra',
            controller: widget._againPasswordController,
            validator: (password) => Validators.passwordValidator(password),
          ),
          Expanded(child: SizedBox()),
          SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomOutlinedButton(
                    width: 210.w,
                    text: 'Mégse',
                    buttonTextStyle: theme.textTheme.titleLarge,
                    onPressed: () async {
                      navigatorKey.currentState!.pop();
                    }),
                Expanded(child: SizedBox()),
                CustomOutlinedButton(
                    width: 210.w,
                    text: 'Jelszó csere',
                    buttonTextStyle: theme.textTheme.titleLarge,
                    buttonStyle: CustomButtonStyles.outlineGreen,
                    onPressed: () {
                      if (widget._newPasswordController.text != widget._againPasswordController.text) {
                        ToastWrapper.showErrorToast(message: 'Különböző új jelszó és ismétlés');
                        return;
                      }
                      if (widget._formKey.currentState!.validate()) {
                        context.read<AuthCubit>().changePassword(
                              currentPassword: widget._currentPasswordController.text,
                              newPassword: widget._newPasswordController.text,
                            );
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required String labelText,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Column(
      children: [
        Text(
          labelText,
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 10),
        CustomTextFormField(
          autofocus: false,
          controller: controller,
          validator: validator,
          obscureText: true,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}
