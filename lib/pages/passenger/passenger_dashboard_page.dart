import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/Order.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/orderService.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/userService.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/vehicleToUserService.dart';

class PassengerDashboardPage extends StatefulWidget {
  const PassengerDashboardPage({super.key});

  @override
  State<PassengerDashboardPage> createState() => _PassengerDashboardPageState();
}

class _PassengerDashboardPageState extends State<PassengerDashboardPage> {
  final UserService _userService = UserService();
  final OrderService _orderService = OrderService();
  final VehicleToUserService _vehicleToUserService = VehicleToUserService();
  Order? currentOrder;

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
            decoration:
                AppDecoration.gradientPrimaryContainerToOnSecondaryContainer,
            child: Column(
              children: [
                SizedBox(height: 272.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Builder(builder: (context) {
                      if (currentOrder != null) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 5.v),
                          child: Column(
                            children: [
                              Text("indulási cím:${currentOrder!.startAddress}",style:theme.textTheme.bodyLarge,),
                              Text("érkezési cím:${currentOrder!.destinationAddress}",style: theme.textTheme.bodyLarge,),
                            ],
                          ),
                        );
                      } else {
                        return _buildPassengerDashboard(context);
                      }
                    }),
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
          Container(
            height: 168.adaptSize,
            width: 168.adaptSize,
            padding: EdgeInsets.all(29.h),
            decoration: AppDecoration.outlineBlack900.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder84,
            ),
            child: GestureDetector(
              onTap: () async {
                String randomDriverId = await _userService.getRandomDriver();
                debugPrint(randomDriverId);
                String vehicleId = await _vehicleToUserService
                    .getVehicleByDriver(randomDriverId);
                Order resp = await _orderService.createOrder(
                    _userService.currentUser!.id, randomDriverId, vehicleId);
                setState(() {
                  currentOrder=resp;
                });
              },
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
}
