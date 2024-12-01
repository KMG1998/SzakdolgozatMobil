import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.gen.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/user/user_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_nav_bar.dart';

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
                  return Container(
                    width: 550.w,
                    height: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusStyle.roundedBorder20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _profileHeadline(onPressed: () {
                          setState(() {
                            _isEditing = true;
                          });
                        }),
                        Text('e-mail: ${state.userData.email}'),
                        Text('név: ${state.userData.name}'),
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
}
