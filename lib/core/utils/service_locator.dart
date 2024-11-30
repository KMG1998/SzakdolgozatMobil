import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/orderService.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/socket_service.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/userService.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/vehicleToUserService.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  getIt.registerLazySingleton(() => OrderService());
  getIt.registerLazySingleton(() => UserService());
  getIt.registerLazySingleton(() => VehicleToUserService());
  getIt.registerLazySingleton(
    () => FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  );
  getIt.registerLazySingleton<SocketService>(() => SocketService());
}
