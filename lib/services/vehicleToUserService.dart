import 'package:dio/dio.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/User.dart';

class VehicleToUserService {
  final dio = Dio(BaseOptions(
      baseUrl: 'http://10.0.2.2:8085/vehicleToUser',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3)));
  User? currentUser;

  static final VehicleToUserService _singleton =
      VehicleToUserService._internal();

  factory VehicleToUserService() {
    return _singleton;
  }

  VehicleToUserService._internal();

  Future<String> getVehicleByDriver(String driverId) async {
    var resp = await dio.get('/findByUser',
        data: {'driverId': driverId},
        options: Options(responseType: ResponseType.json, headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
          'accept': 'application/json'
        }));
    String vehicleId = resp.data.toString();
    return vehicleId;
  }
}
