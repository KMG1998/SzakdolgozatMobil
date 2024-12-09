import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/order.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/offer_response.dart';
import 'package:szakdolgozat_magantaxi_mobil/routes/app_routes.dart';

class OrderService {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8085/order',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
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
      options.headers['cookie'] = 'token=${await getIt.get<FlutterSecureStorage>().read(key: 'token')}';
      handler.next(options);
    }));
    _dio.interceptors
        .add(InterceptorsWrapper(onResponse: (Response response, ResponseInterceptorHandler handler) {
      if (response.statusCode == 401) {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.loginScreen);
        return;
      }
      handler.next(response);
    }));
  }

  Future<OfferResponse?> getOffer(
      {required double passengerLat,
      required double passengerLongit,
      required double destLat,
      required double destLongit,
      required int personAmount}) async {
    try {
      final resp = await _dio.post<String>(
        '/getOffer',
        data: {
          'passengerLat': passengerLat,
          'passengerLongit': passengerLongit,
          'destLat': destLat,
          'destLongit': destLongit,
          'personAmount': personAmount,
        },
      );
      if(resp.data == null || resp.data!.isEmpty){
        return null;
      }
      await getIt.get<FlutterSecureStorage>().write(key: 'orderData', value: resp.data);
      return resp.data!.isNotEmpty ? OfferResponse.fromJson(jsonDecode(resp.data!)) : null;
    } catch (e) {
      _logger.e(e);
      return null;
    }
  }

  Future<List<Order>?> getHistory() async{
    final resp = await _dio.get('/getPassengerHistory');
    if(resp.statusCode == 200){
      return (jsonDecode(resp.data)["history"] as List).map((e) => Order.fromJson(e)).toList();
    }
    return null;
  }
}
