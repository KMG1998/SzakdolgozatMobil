import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/order_service.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/review_service.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/socket_service.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/user_service.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  getIt.registerLazySingleton(() => OrderService());
  getIt.registerLazySingleton(() => UserService());
  getIt.registerLazySingleton(() => SocketService());
  getIt.registerLazySingleton(() => ReviewService());
  getIt.registerLazySingleton(
    () => FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  );
}
