import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/popups/change_password_dialog.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.gen.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/auth/auth_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/user/user_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/routes/app_routes.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/app_decoration.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/custom_button_style.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_nav_bar.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';

class PassengerProfilePage extends StatefulWidget {
  const PassengerProfilePage({super.key});

  @override
  State<PassengerProfilePage> createState() => _PassengerProfilePageState();
}

class _PassengerProfilePageState extends State<PassengerProfilePage> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
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
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 550.w,
                          height: 200.h,
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
                              _profileHeadline(onPressed: () {
                                setState(() {
                                  _isEditing = true;
                                });
                              }),
                              SizedBox(height: 20),
                              Text(
                                'e-mail: ${state.userData.email}',
                                style: theme.textTheme.titleLarge,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'név: ${state.userData.name}',
                                style: theme.textTheme.titleLarge,
                              ),
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
                        _createButton(text: 'értékelések megtekintése', onPressed: () {
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
                    ),
                  );
                }
                if (state is UserError) {
                  Fluttertoast.showToast(msg: state.errorMessage);
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

  Widget _profileHeadline({required void Function() onPressed}) {
    return Container(
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
