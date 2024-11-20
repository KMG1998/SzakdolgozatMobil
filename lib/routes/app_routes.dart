import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/auth/registration_passenger_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/auth/login_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/passenger/new_reserve_car_select_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/passenger//new_reserve_wait_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/passenger/passenger_dashboard_page.dart';

class AppRoutes {
  static const String registrationPassengerScreen =
      '/registration_passenger_screen';

  static const String passengerDashboardPage = '/passenger_dashboard_page';

  static const String loginScreen = '/login_screen';

  static const String driverDashboardScreen = '/driver_dashboard_screen';

  static const String newReserveCarSelectScreen =
      '/new_reserve_car_select_screen';

  static const String newReserveWaitScreen = '/new_reserve_wait_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    registrationPassengerScreen: (context) => const RegistrationPassengerScreen(),
    loginScreen: (context) => const LoginScreen(),
    newReserveCarSelectScreen: (context) => NewReserveCarSelectScreen(),
    newReserveWaitScreen: (context) => NewReserveWaitScreen(),
    passengerDashboardPage: (context) => PassengerDashboardPage(),
  };
}
