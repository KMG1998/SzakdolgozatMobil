import 'dart:math';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/User.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/secureStorage.dart';

import '../core/utils/service_locator.dart';

class UserService {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8085/user',
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

  User? currentUser;

  UserService() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      options.headers['cookie'] = 'token=${await getIt.get<SecureStorage>().getValue('token')};';
      handler.next(options);
    }));
  }

  Future<User> getUser(String uid) async {
    var resp = await _dio.get(
      '',
      data: {'userId': uid},
    );
    return User.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<bool> createPassenger(String email, String password, String name) async {
      var resp = await _dio.post('/signUpPassenger',
          data: {'email': email, 'password': password, 'name': name},
          options: Options(responseType: ResponseType.json));
      return resp.statusCode == 200;
  }

  Future<User> logUserIn(String email, String password) async {
    var resp = await _dio.post(
      '/signInPassenger',
      data: {
        'email': email,
        'password': password,
      },
    );
    final token = resp.headers['set-cookie']![0].split(';')[0].split('=')[1];
    await getIt.get<SecureStorage>().setValue('token', token);
    currentUser = User.fromJson(resp.data as Map<String, dynamic>);
    return currentUser!;
  }

  Future<bool> resetPassword(String email) async {
    var resp = await _dio.post(
      '/resetPassword',
      data: {
        'userEmail': email,
      },
    );
    if (resp.statusCode == 200) {
      return true;
    }
    return false;
  }
}
