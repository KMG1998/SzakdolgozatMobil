import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/User.dart';

class UserService {
  final dio = Dio();

  UserService() {
    dio.options.baseUrl = 'http://10.0.2.2:8085/user';
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<User> createPassenger(
      String email, String password, String name) async {
    var resp = await dio.post('/create',
            data: {
              'email': email,
              'password': password,
              'name': name,
              'type': '5'
            },
            options: Options(responseType: ResponseType.json,headers: {'Access-Control-Allow-Origin': '*','Content-Type': 'application/json','accept':'application/json'}));
    return User.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<User> logUserIn(
      String email, String password) async {
    var resp = await dio.post('/signIn',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(responseType: ResponseType.json,headers: {'Access-Control-Allow-Origin': '*','Content-Type': 'application/json','accept':'application/json'}));
    return User.fromJson(resp.data as Map<String, dynamic>);
  }
}
