import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/User.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/order/order_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/user/user_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/map_widget.dart';

class PassengerDashboardPage extends StatefulWidget {
  const PassengerDashboardPage({super.key});

  @override
  State<PassengerDashboardPage> createState() => _PassengerDashboardPageState();
}

class _PassengerDashboardPageState extends State<PassengerDashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
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
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 1.v),
            decoration: AppDecoration.gradientPrimaryContainerToOnSecondaryContainer,
            child: Column(
              children: [
                SizedBox(height: 272.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: BlocBuilder<OrderCubit, OrderState>(
                      builder: (context, state) {
                        if (state.currentRoute != null) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 5.v,top: 5.h),
                            child: Column(
                              children: [
                                Text(
                                  /*"indulási cím:${state.currentOrder!.startAddress}"*/
                                  'ind',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Text(
                                  /*"érkezési cím:${state.currentOrder!.destinationAddress}"*/
                                  "cel",
                                  style: theme.textTheme.bodyLarge,
                                ),
                                MapWidget(initialPos: state.currentPassengerPos!),
                              ],
                            ),
                          );
                        } else {
                          return _buildPassengerDashboard(context);
                        }
                      },
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
  Widget _buildPassengerDashboard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.v),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              _requestLocationPermission();
              if (await Permission.location.isGranted) {
                _getOffer(context);
              }
            },
            child: Container(
              height: 168.adaptSize,
              width: 168.adaptSize,
              padding: EdgeInsets.all(29.h),
              decoration: AppDecoration.outlineBlack900.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder84,
              ),
              child: CustomImageView(
                imagePath: Assets.imagesNewFuvarButton,
                height: 108.adaptSize,
                width: 108.adaptSize,
                alignment: Alignment.center,
              ),
            ),
          ),
          SizedBox(height: 30.v),
          Text(
            "Új foglalás",
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  void _requestLocationPermission() async {
    const permission = Permission.location;
    if (await permission.isDenied) {
      await permission.request();
    }
  }

  void _getOffer(BuildContext context) {
    context.read<OrderCubit>().createOrder();
  }
}
