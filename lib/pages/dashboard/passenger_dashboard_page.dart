import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/app_export.dart';
import 'package:szakdolgozat_magantaxi_mobil/generated/assets.gen.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/order/order_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_nav_bar.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_outlined_button.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/custom_text_form_field.dart';
import 'package:szakdolgozat_magantaxi_mobil/widgets/map_widget.dart';

class PassengerDashboardPage extends StatefulWidget {
  const PassengerDashboardPage({super.key});

  @override
  State<PassengerDashboardPage> createState() => _PassengerDashboardPageState();
}

class _PassengerDashboardPageState extends State<PassengerDashboardPage> {
  Location? destinationLocation;
  late TextEditingController personNumController;
  late TextEditingController destinationAddressController;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    personNumController = TextEditingController();
    destinationAddressController = TextEditingController();
  }

  @override
  void dispose() {
    personNumController.dispose();
    destinationAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballClipRotatePulse,
                                ),
                              ),
                            );
                          }
                          if (state is OrderLoaded) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 5.w, top: 5.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(10),
                                    width: 550.w,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Sofőr átlaga: ${state.vehicleData.reviewAvg?.toStringAsFixed(2)}',
                                          style: theme.textTheme.titleLarge,
                                        ),
                                        Text(
                                          'Jármű színe: ${state.vehicleData.vehicleColor}',
                                          style: theme.textTheme.titleLarge,
                                        ),
                                        Text(
                                          'Jármű Típusa: ${state.vehicleData.vehicleType}',
                                          style: theme.textTheme.titleLarge,
                                        ),
                                        Text(
                                          'Jármű rendszáma: ${state.vehicleData.vehiclePlate}',
                                          style: theme.textTheme.titleLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                  MapWidget(initialPos: state.currentPassengerPos),
                                  SizedBox(height: 20),
                                  CustomOutlinedButton(
                                    text: 'Mégse',
                                    buttonStyle: CustomButtonStyles.outlineRed,
                                    onPressed: () {
                                      destinationLocation = null;
                                      destinationAddressController.text = '';
                                      context.read<OrderCubit>().cancelRide();
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
            bottomNavigationBar: CustomNavBar(activeNum: 1)),
      ),
    );
  }

  Widget _buildPassengerDashboard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            destinationLocation == null
                ? SizedBox(
                    width: 500.w,
                    height: 410.h,
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
                      searchController: destinationAddressController,
                      onNext: (geoRes) => {
                        setState(() {
                          destinationLocation = geoRes?.geometry.location;
                        })
                      },
                    ),
                  )
                : Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 330.w,
                          child: Text(
                            'Uticél:${destinationAddressController.text}',
                            style: theme.textTheme.titleLarge,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                            onPressed: () => setState(() {
                                  destinationAddressController.text = '';
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
            SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                _requestLocationPermission();
                if (await Permission.location.isDenied) {
                  Fluttertoast.showToast(msg: 'Kérjük, engedélyezze és kapcsolja be a GPS-t!');
                  return;
                }
                if (destinationLocation == null) {
                  Fluttertoast.showToast(msg: 'Kérjük, válasszon uticélt!');
                }
                if (personNumController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Kérjük, adja meg a személyek számát!');
                }
                context.read<OrderCubit>().getOffer(destinationLocation!, int.parse(personNumController.text));
              },
              child: Column(
                children: [
                  CustomImageView(
                    imagePath: Assets.lib.assets.images.newRideButton.path,
                    height: 130.h,
                    width: 130.w,
                    alignment: Alignment.center,
                  ),
                  Text(
                    "Új foglalás",
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
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
