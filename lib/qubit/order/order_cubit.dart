import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/Order.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/orderService.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState(isLoading: false, hasError: false));
  final _logger = Logger();

  getOffer() async {
    try {
      emit(state.copyWith(
        currentOrder: null,
        isLoading: true,
        hasError: false,
        errorMessage: null,
      ));
      Position currentPos = await Geolocator.getCurrentPosition();
      var routeResp = await getIt.get<OrderService>().getOffer(
          passengerLat: currentPos.latitude,
          passengerLongit: currentPos.longitude,
          destLat:   46.421727384139864,
          destLongit: 20.332100135254265);
      if (routeResp == null) {
        emit(state.copyWith(isLoading: false, hasError: true, errorMessage: 'NO_AVAILABLE_DRIVER'));
        return;
      }
      var currentRoute = PolylinePoints().decodePolyline(routeResp[0]['overview_polyline']['points']);
      emit(state.copyWith(
          currentOrder: null,
          isLoading: false,
          hasError: false,
          errorMessage: null,
          currentPassengerPos: currentPos,
          currentRoute: currentRoute));
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(isLoading: false, hasError: true, errorMessage: 'UNKNOWN ERROR'));
    }
  }

  createOrder() async {
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
