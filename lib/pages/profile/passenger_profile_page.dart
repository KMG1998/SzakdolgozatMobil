import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/popups/change_password_dialog.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/toast_wrapper.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/validators.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.gen.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/auth/auth_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/user/user_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/routes/app_routes.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/app_decoration.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/custom_button_style.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_nav_bar.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';

class PassengerProfilePage extends StatefulWidget {
  const PassengerProfilePage({super.key});

  @override
  State<PassengerProfilePage> createState() => _PassengerProfilePageState();
}

class _PassengerProfilePageState extends State<PassengerProfilePage> {
  bool _isEditing = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.5, 0),
                end: const Alignment(0.5, 1),
                colors: [
                  theme.colorScheme.primaryContainer,
                  appTheme.blue100,
                  theme.colorScheme.onSecondaryContainer,
                ],
              ),
            ),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserInit) {
                  context.read<UserCubit>().getUserData();
                }
                if (state is UserLoaded) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 550.w,
                        height: 230.h,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusStyle.roundedBorder20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _isEditing
                                ? _profileEdit(
                                    currentName: state.userData.name,
                                    onSave: (newName) {
                                      context.read<UserCubit>().changeName(newName);
                                      setState(() {
                                        _isEditing = false;
                                      });
                                    },
                                    onCancel: () {
                                      setState(() {
                                        _isEditing = false;
                                      });
                                    })
                                : _profileHeadline(
                                    email: state.userData.email,
                                    name: state.userData.name,
                                    onPressed: () {
                                      setState(() {
                                        _isEditing = true;
                                      });
                                    }),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      _createButton(
                          text: 'jelszó megváltoztatása',
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (ctx) => ChangePasswordDialog());
                          }),
                      _createButton(
                          text: 'értékelések megtekintése',
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.receivedReviews);
                          }),
                      SizedBox(height: 50),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            context.read<AuthCubit>().logOut();
                          },
                          icon: Assets.lib.assets.images.logOut.svg(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Kijelentkezés',
                        style: theme.textTheme.titleLarge,
                      )
                    ],
                  );
                }
                if (state is UserError) {
                  ToastWrapper.showErrorToast(message: state.errorMessage);
                  return SizedBox();
                }
                return _loadingIndicator;
              },
            ),
          ),
          bottomNavigationBar: CustomNavBar(activeNum: 2),
        ),
      ),
    );
  }

  final Widget _loadingIndicator = Center(
    child: Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotatePulse,
          colors: [Colors.black],
        ),
      ),
    ),
  );

  Widget _profileHeadline({required String name, required String email, required void Function() onPressed}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Profil adatok',
                style: theme.textTheme.headlineLarge,
              ),
              Expanded(child: SizedBox()),
              IconButton(
                onPressed: onPressed,
                icon: Assets.lib.assets.images.editButton.svg(),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          'e-mail: $email',
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 20),
        Text(
          'név: $name',
          style: theme.textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget _profileEdit(
      {required String currentName, required void Function(String newName) onSave, required void Function() onCancel}) {
    final nameController = TextEditingController();
    nameController.text = currentName;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2),
            ),
          ),
          child: Text(
            'Név szerkesztése',
            style: theme.textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                'Név',
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                controller: nameController,
                validator: (name) => Validators.nameValidator(name),
              ),
            ],
          ),
        ),
        SizedBox(height: 25.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomOutlinedButton(
              width: 210.w,
              text: 'Mégse',
              buttonStyle: CustomButtonStyles.outlineRed,
              onPressed: onCancel,
            ),
            Expanded(child: SizedBox()),
            CustomOutlinedButton(
                width: 210.w,
                text: 'Mentés',
                buttonStyle: CustomButtonStyles.outlineGreen,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    onSave(nameController.text);
                    return;
                  }
                  ToastWrapper.showErrorToast(message: 'Hibás adatok');
                }),
          ],
        )
      ],
    );
  }

  Widget _createButton({required String text, required void Function() onPressed}) {
    return CustomOutlinedButton(
      text: text,
      buttonStyle: CustomButtonStyles.outlineBlack,
      margin: EdgeInsets.symmetric(vertical: 10),
      buttonTextStyle: theme.textTheme.headlineLarge!.copyWith(
        decoration: TextDecoration.underline,
      ),
      onPressed: onPressed,
    );
  }
}
