import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/registration_passenger_screen/registration_passenger_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/auth/login_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/driver_dashboard_screen/driver_dashboard_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/new_reserve_car_select_screen/new_reserve_car_select_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/registration_precond_screen/registration_precond_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/new_reserve_wait_screen/new_reserve_wait_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String registrationPassengerScreen =
      '/registration_passenger_screen';

  static const String passengerDashboardPage = '/passenger_dashboard_page';

  static const String loginScreen = '/login_screen';

  static const String driverDashboardScreen = '/driver_dashboard_screen';

  static const String newReserveCarSelectScreen =
      '/new_reserve_car_select_screen';

  static const String registrationPrecondScreen =
      '/registration_precond_screen';

  static const String newReserveWaitScreen = '/new_reserve_wait_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    registrationPassengerScreen: (context) => RegistrationPassengerScreen(),
    loginScreen: (context) => LoginScreen(),
    driverDashboardScreen: (context) => DriverDashboardScreen(),
    newReserveCarSelectScreen: (context) => NewReserveCarSelectScreen(),
    registrationPrecondScreen: (context) => RegistrationPrecondScreen(),
    newReserveWaitScreen: (context) => NewReserveWaitScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
