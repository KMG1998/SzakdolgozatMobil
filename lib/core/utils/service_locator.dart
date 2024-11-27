import 'package:get_it/get_it.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/orderService.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/secureStorage.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/streamService.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/userService.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/vehicleToUserService.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  getIt.registerLazySingleton(() => OrderService());
  getIt.registerLazySingleton(() => UserService());
  getIt.registerLazySingleton(() => VehicleToUserService());
  getIt.registerLazySingleton(() => SecureStorage());
  getIt.registerLazySingleton(() => SocketService());
}