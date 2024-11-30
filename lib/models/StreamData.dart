import 'package:szakdolgozat_magantaxi_mobil/core/enums.dart';

class StreamData {
  final String data;

  StreamData( {required this.data});

  StreamData.fromJson(Map<String, dynamic> json):
        data = json['data'] as String;

  Map<String, dynamic> toJson() => {
        'data': data,
      };
}
