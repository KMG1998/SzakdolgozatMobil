import 'dart:convert';

import 'package:google_directions_api/google_directions_api.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/vehicle_data.dart';

class OfferResponse {
  final String socketRoomId;
  final VehicleData vehicleData;
  final List<DirectionsRoute> routes;

  OfferResponse({required this.socketRoomId, required this.vehicleData, required this.routes});

  OfferResponse.fromJson(Map<String, dynamic> json)
      : socketRoomId = json['socketId'],
        vehicleData = VehicleData.fromJson(jsonDecode(json['vehicleData'])),
        routes =  (json['routes'] as List).map((e) => DirectionsRoute.fromMap(e)).toList();

  Map<String, dynamic> toJson() => {
        'socketId': socketRoomId,
        'vehicleData': vehicleData,
        'routes': routes,
      };
}
