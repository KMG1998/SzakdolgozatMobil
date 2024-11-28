import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:logger/logger.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/enums.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/StreamData.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/vehicle_data.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/orderService.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/secureStorage.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/socket_service.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInit());
  final _logger = Logger();

  getOffer(Location destLoc, int personAmount) async {
    try {
      emit(OrderLoading());
      Position currentPos = await Geolocator.getCurrentPosition();
      var offerResp = await getIt.get<OrderService>().getOffer(
          passengerLat: currentPos.latitude,
          passengerLongit: currentPos.longitude,
          destLat: destLoc.lat,
          destLongit: destLoc.lng,
          personAmount: personAmount);
      if (offerResp == null) {
        emit(OrderError(errorMessage: 'NO_AVAILABLE_DRIVER'));
        return;
      }
      var currentRoute = PolylinePoints().decodePolyline(offerResp.routes[0].overviewPolyline!.points!);
      final token = await getIt.get<SecureStorage>().getValue('token');
      getIt.get<SocketService>().connectToRoom(offerResp.socketRoomId, token!, _onDriverCancel);
      emit(
          OrderLoaded(vehicleData: offerResp.vehicleData, currentPassengerPos: currentPos, currentRoute: currentRoute));
    } catch (e) {
      _logger.e(e);
      emit(OrderError(errorMessage: 'UNKNOWN ERROR'));
    }
  }

  cancelRide() {
    try {
      final socketService = getIt.get<SocketService>();
      emit(OrderLoading());
      socketService.emitData(StreamData(dataType: SocketDataType.passengerCancel, data: ''));
      socketService.disconnectChannel();
      emit(OrderInit());
    } catch (e) {
      _logger.e(e);
    }
  }

  _onDriverCancel() {
    emit(OrderInit(error: 'A sofőr visszautasította'));
  }
}
