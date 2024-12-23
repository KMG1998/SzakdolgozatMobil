import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/order_review.dart';
import 'package:szakdolgozat_magantaxi_mobil/routes/app_routes.dart';

class ReviewService{
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8085/review',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Access-Control-Request-Headers': 'Origin',
      'Origin': 'mobileApp',
    },
  ));

  ReviewService() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      options.headers['cookie'] = 'token=${await getIt.get<FlutterSecureStorage>().read(key:'token')};';
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

  Future<bool> createReview({required double score, String? reviewText}) async{
    final resp = await _dio.post('/create',data: {'score':score,'reviewText':reviewText});
    return resp.statusCode == 200;
  }

  Future<List<OrderReview>?> getReceivedReviews() async {
    final resp = await _dio.get('/getReceived');
    if(resp.statusCode == 200){
      return (jsonDecode(resp.data) as List).map((e) => OrderReview.fromJson(e)).toList();
    }
    return null;
  }
}