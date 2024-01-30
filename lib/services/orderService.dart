import 'package:dio/dio.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/Order.dart';

class OrderService {
  final dio = Dio(BaseOptions(
      baseUrl: 'http://10.0.2.2:8085/order',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3)));
  Order? currentOrder;

  static final OrderService _singleton = OrderService._internal();

  factory OrderService() {
    return _singleton;
  }

  OrderService._internal();

  Future<Order> createOrder(String passengerId,String driverId,vehicleId) async {
    var resp = await dio.post('/create',
        data: {'customerId': passengerId, 'driverId': driverId, 'vehicleId':vehicleId},
        options: Options(responseType: ResponseType.json, headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
          'accept': 'application/json'
        }));
    currentOrder = Order.fromJson(resp.data as Map<String, dynamic>);
    return currentOrder!;
  }

  Future<Order> getLatestForDriver(String driverId) async {
    var resp = await dio.get('/getLatestForDriver',
        data: {'driverId': driverId},
        options: Options(responseType: ResponseType.json, headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
          'accept': 'application/json'
        }));
    currentOrder = Order.fromJson(resp.data as Map<String, dynamic>);
    return currentOrder!;
  }
}
