import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/Order.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/userService.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState(isLoading: false, hasError: false));

  createOrder() async {
    emit(state.copyWith(
      currentOrder: null,
      isLoading: true,
      hasError: false,
      errorMessage: null,
    ));
    Position currentPos = await Geolocator.getCurrentPosition();
    var routeResp = await getIt.get<UserService>().getDriver(
        passengerLat: currentPos.latitude,
        passengerLongit: currentPos.longitude,
        destLat: 46.240255191632635,
        destLongit: 20.142768112026104) as Map<String,dynamic>;
    var currentRoute = PolylinePoints().decodePolyline(routeResp['overview_polyline']['points']);
    emit(state.copyWith(
      currentOrder: null,
      isLoading: false,
      hasError: false,
      errorMessage: null,
      currentPassengerPos: currentPos,
      currentRoute: currentRoute
    ));
    /*String vehicleId = await getIt.get<VehicleToUserService>().getVehicleByDriver(randomDriverId);
    Order newOrder = await getIt
        .get<OrderService>()
        .createOrder(getIt.get<UserService>().currentUser!.id, randomDriverId, vehicleId);
    emit(state.copyWith(
      currentOrder: newOrder,
      isLoading: false,
      hasError: false,
      errorMessage: null,
    ));*/
  }
}
