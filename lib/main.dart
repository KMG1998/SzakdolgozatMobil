import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:szakdolgozat_magantaxi_mobil/pages/splash/splash_screen.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/auth/auth_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/history/history_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/order/order_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/reviewList/review_list_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/qubit/user/user_cubit.dart';
import 'package:szakdolgozat_magantaxi_mobil/routes/app_routes.dart';
import 'package:szakdolgozat_magantaxi_mobil/theme/theme_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/service_locator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  ThemeHelper().changeTheme('primary');
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(675, 948),
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => OrderCubit()),
            BlocProvider(create: (context) => UserCubit()),
            BlocProvider(create: (context) => HistoryCubit()),
            BlocProvider(create: (context) => ReviewListCubit()),
          ],
          child: MaterialApp(
            theme: theme,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            routes: AppRoutes.routes,
            navigatorKey: navigatorKey,
          ),
        );
      },
    );
  }
}
