import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/Order.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/orderService.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInit());
  final _logger = Logger();

  getOffer(Location destLoc, int personAmount) async {
    try {
      emit(OrderLoading());
      Position currentPos = await Geolocator.getCurrentPosition();
      _logger.d('lat ${destLoc.lat}, lng ${destLoc.lng}');
      var routeResp = await getIt.get<OrderService>().getOffer(
          passengerLat: currentPos.latitude,
          passengerLongit: currentPos.longitude,
          destLat: destLoc.lat,
          destLongit: destLoc.lng,
          personAmount: personAmount);
      if (routeResp == null) {
        emit(OrderError( errorMessage: 'NO_AVAILABLE_DRIVER'));
        return;
      }
      var currentRoute = PolylinePoints().decodePolyline(routeResp[0]['overview_polyline']['points']);
      emit(OrderLoaded(
          currentPassengerPos: currentPos,
          currentRoute: currentRoute));
    } catch (e) {
      _logger.e(e);
      emit(OrderError(errorMessage: 'UNKNOWN ERROR'));
    }
  }

  finishRide() {
    try {
      emit(OrderLoading());
      emit(OrderInit());
    }catch(e){
      _logger.e(e);
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
