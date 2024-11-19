
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/secureStorage.dart';

class OrderService {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8085/order',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Access-Control-Request-Headers': 'Origin',
      'Origin': 'mobileApp',
    },
    responseType: ResponseType.json,
  ));

  final _logger = Logger();

  OrderService() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      options.headers['cookie'] = 'token=${await getIt.get<SecureStorage>().getValue('token')};';
      handler.next(options);
    }));
  }

  /*Future<Order> createOrder(String passengerId, String driverId, vehicleId) async {
    var resp = await _dio.post('/create',
        data: {'customerId': passengerId, 'driverId': driverId, 'vehicleId': vehicleId},
        options: Options(responseType: ResponseType.json, headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
          'accept': 'application/json'
        }));
  }

  Future<Order> getLatestForDriver(String driverId) async {
    var resp = await _dio.get('/getLatestForDriver',
        data: {'driverId': driverId},
        options: Options(responseType: ResponseType.json, headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
          'accept': 'application/json'
        }));
  }*/

  Future<dynamic> getOffer(
      {required double passengerLat,
      required double passengerLongit,
      required double destLat,
      required double destLongit}) async {
    try {
      final resp = await _dio.post(
        '/getOffer',
        data: {
          'passengerLat': passengerLat,
          'passengerLongit': passengerLongit,
          'destLat': destLat,
          'destLongit': destLat,
        },
      );
      _logger.d(resp.data);
      return (resp.data is List<dynamic>) ? resp.data : null;
    }catch(e){
      _logger.e(e);
      return null;
    }
  }
}
