import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/auth/registration_passenger_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/auth/login_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/driver/driver_dashboard_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/passenger/new_reserve_car_select_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/auth/registration_precond_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/passenger//new_reserve_wait_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/passenger/passenger_dashboard_page.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/login/login_cubit.dart';

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
    registrationPassengerScreen: (context) => const RegistrationPassengerScreen(),
    loginScreen: (context) => const LoginScreen(),
    driverDashboardScreen: (context) => DriverDashboardScreen(),
    newReserveCarSelectScreen: (context) => NewReserveCarSelectScreen(),
    registrationPrecondScreen: (context) => const RegistrationPrecondScreen(),
    newReserveWaitScreen: (context) => NewReserveWaitScreen(),
    passengerDashboardPage: (context) => const PassengerDashboardPage(),
  };
}
