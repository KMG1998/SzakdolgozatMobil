import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:logger/logger.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/order/order_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/map_widget.dart';

final _logger = Logger();

class PassengerDashboardPage extends StatefulWidget {
  PassengerDashboardPage({super.key});

  @override
  State<PassengerDashboardPage> createState() => _PassengerDashboardPageState();
}

class _PassengerDashboardPageState extends State<PassengerDashboardPage> {
  Location? destinationLocation;
  String? destinationAddress;
  TextEditingController personNumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                Expanded(
                  child: BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      if (state is OrderLoading) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: LoadingIndicator(indicatorType: Indicator.ballClipRotatePulse),
                          ),
                        );
                      }
                      if (state is OrderLoaded) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 5.v, top: 5.h),
                          child: Column(
                            children: [
                              MapWidget(initialPos: state.currentPassengerPos),
                              CustomOutlinedButton(
                                text: 'off',
                                onPressed: () {
                                  _logger.d('clicked');
                                  destinationLocation = null;
                                  destinationAddress = null;
                                  context.read<OrderCubit>().finishRide();
                                },
                              )
                            ],
                          ),
                        );
                      } else {
                        return Center(child: _buildPassengerDashboard(context));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          destinations: <Widget>[
            NavigationDestination(
                icon: SizedBox(
                  width: 50,
                  height: 50,
                  child: SvgPicture.asset(
                    Assets.imagesImgClock,
                  ),
                ),
                label: ''),
            NavigationDestination(icon: SvgPicture.asset(Assets.imagesImgHome), label: ''),
            NavigationDestination(icon: SvgPicture.asset(Assets.imagesImgHome), label: ''),
          ],
          indicatorColor: Color(0XFFB2D8FF),
          indicatorShape: RoundedRectangleBorder(),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPassengerDashboard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.v),
      child: SingleChildScrollView(
        child: Column(
          children: [
            destinationLocation == null
                ? Container(
                    width: 400.v,
                    height: 800.h,
                    child: MapLocationPicker(
                      apiKey: 'AIzaSyAqSuEn0aAlAx37yRyafg6WF_xNOOwUI38',
                      language: 'hu',
                      compassEnabled: false,
                      indoorViewEnabled: false,
                      searchHintText: 'Uticél keresése',
                      rotateGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      hideLocationButton: true,
                      hideMapTypeButton: true,
                      hideMoreOptions: true,
                      mapToolbarEnabled: false,
                      onNext: (geoRes) => {
                        setState(() {
                          destinationLocation = geoRes?.geometry.location;
                          destinationAddress = geoRes?.formattedAddress;
                        })
                      },
                    ),
                  )
                : Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 340.v,
                          child: Text(
                            'Uticél:$destinationAddress',
                            style: theme.textTheme.titleLarge,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                            onPressed: () => setState(() {
                                  destinationLocation = null;
                                }),
                            icon: Icon(Icons.dangerous_outlined))
                      ],
                    ),
                  ),
            SizedBox(height: 20),
            CustomTextFormField(
              key: Key('personAmountInput'),
              hintText: 'Személyek száma',
              textStyle: theme.textTheme.bodyLarge,
              controller: personNumController,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                _requestLocationPermission();
                if (await Permission.location.isGranted && destinationLocation != null) {
                  context.read<OrderCubit>().getOffer(destinationLocation!, int.parse(personNumController.text));
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
                  imagePath: Assets.imagesNewRideButton,
                  height: 108.adaptSize,
                  width: 108.adaptSize,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              "Új foglalás",
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(
              height: 60.h,
            )
          ],
        ),
      ),
    );
  }

  void _requestLocationPermission() async {
    const permission = Permission.location;
    if (await permission.isDenied) {
      await permission.request();
    }
  }
}
