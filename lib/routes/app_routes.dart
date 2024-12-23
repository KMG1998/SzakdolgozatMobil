import 'package:flutter/material.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/auth/registration_passenger_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/auth/login_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/dashboard/passenger_dashboard_page.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/history/history_order_details_page.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/history/passenger_history_page.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/profile/passenger_profile_page.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/profile/received_review_list.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/splash/splash_screen.dart';

class AppRoutes {
  static const String registrationPassengerScreen = '/registration_passenger_screen';
  static const String passengerDashboardPage = '/passenger_dashboard_page';
  static const String passengerHistoryPage = '/passenger_history_page';
  static const String passengerProfilePage = '/passenger_profile_page';
  static const String historyOrderDetailsPage = '/history_order_details_page';
  static const String loginScreen = '/login_screen';
  static const String splashScreen = '/splash_screen';
  static const String receivedReviews = '/received_reviews';

  static Map<String, WidgetBuilder> routes = {
    registrationPassengerScreen: (context) => const RegistrationPassengerScreen(),
    loginScreen: (context) => const LoginScreen(),
    passengerDashboardPage: (context) => PassengerDashboardPage(),
    passengerHistoryPage: (context) => PassengerHistoryPage(),
    passengerProfilePage: (context) => PassengerProfilePage(),
    historyOrderDetailsPage: (context) => HistoryOrderDetails(),
    splashScreen: (context) => SplashScreen(),
    receivedReviews: (context) => ReceivedReviewList(),
  };
}
