import 'package:szakdolgozat_magantaxi_mobil/core/enums.dart';

class StreamData {
  final StreamDataType dataType;
  final String data;

  StreamData({required this.dataType, required this.data});

  StreamData.fromJson(Map<String, dynamic> json)
      : dataType = StreamDataType.values.firstWhere((dataType) {
          return dataType.name.toString() == json['dataType'];
        }),
        data = json['data'] as String;

  Map<String, dynamic> toJson() => {
        'dataType': dataType.name,
        'data': data,
      };
}
