import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/enums.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/popups/order_review_dialog.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/toast_wrapper.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/offer_response.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/stream_data.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/order_review.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/vehicle_data.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/order_service.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/review_service.dart';
import 'package:szakdolgozat_magantaxi_mobil/services/socket_service.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInit());
  final _logger = Logger();
  final _noScreenshot = NoScreenshot.instance;

  initState() async {
    emit(OrderLoading());
    final secureStorage = getIt.get<FlutterSecureStorage>();
    final roomId = await secureStorage.read(key: 'roomId');
    _logger.d(roomId);
    if (roomId == null) {
      emit(OrderWaiting());
      return;
    }
    final socketService = getIt.get<SocketService>();
    socketService.connectToRoom(
        roomId: roomId,
        onDriverCancel: _onDriverCancel,
        onOrderFinish: _onOrderFinish,
        onPickupPassenger: _onPickupPassenger);
    final orderDataString = await secureStorage.read(key: 'orderData');
    final orderData = OfferResponse.fromJson(jsonDecode(orderDataString!));
    final currentRoute = PolylinePoints().decodePolyline(orderData.routes.first.overviewPolyline!.points!);
    final currentPos = await Geolocator.getCurrentPosition();
    emit(
      OrderLoaded(
        vehicleData: orderData.vehicleData,
        currentPassengerPos: currentPos,
        currentRoute: currentRoute,
        passengerPickedUp: false,
      ),
    );
    return;
  }

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
        ToastWrapper.showErrorToast(message: 'Nincs elérhető sofőr');
        emit(OrderWaiting());
        return;
      }
      var currentRoute = PolylinePoints().decodePolyline(offerResp.routes[0].overviewPolyline!.points!);
      await getIt.get<FlutterSecureStorage>().write(key: 'roomId', value: offerResp.socketRoomId);
      getIt.get<SocketService>().connectToRoom(
          roomId: offerResp.socketRoomId,
          onDriverCancel: _onDriverCancel,
          onOrderFinish: _onOrderFinish,
          onPickupPassenger: _onPickupPassenger);
      await _noScreenshot.screenshotOff();
      emit(
        OrderLoaded(
          vehicleData: offerResp.vehicleData,
          currentPassengerPos: currentPos,
          currentRoute: currentRoute,
          passengerPickedUp: false,
        ),
      );
    } catch (e) {
      _logger.e(e);
    }
  }

  cancelRide() async {
    try {
      emit(OrderLoading());
      final secureStorage = getIt.get<FlutterSecureStorage>();
      await secureStorage.delete(key: 'roomId');
      await secureStorage.delete(key: 'orderData');
      final socketService = getIt.get<SocketService>();
      await socketService.emitData(SocketDataType.passengerCancel, StreamData(data: ''));
      socketService.disconnectRoom();
      await _noScreenshot.screenshotOn();
      emit(OrderWaiting());
    } catch (e) {
      _logger.e(e);
      await _noScreenshot.screenshotOn();
      emit(OrderWaiting());
    }
  }

  _createReview() async {
    OrderReview? newReview;
    await showDialog<OrderReview?>(context: navigatorKey.currentContext!, builder: (ctx) => OrderReviewDialog())
        .then((value) => {newReview = value});
    if (newReview != null) {
      final success =
          await getIt.get<ReviewService>().createReview(score: newReview!.score, reviewText: newReview!.reviewText);
      if (success) {
        ToastWrapper.showSuccessToast(message: 'Sikeres értékelés');
      }
    }
  }

  _onDriverCancel() async {
    await _noScreenshot.screenshotOn();
    final secureStorage = getIt.get<FlutterSecureStorage>();
    await secureStorage.delete(key: 'roomId');
    await secureStorage.delete(key: 'orderData');
    emit(OrderWaiting(error: 'A sofőr visszautasította'));
  }

  _onOrderFinish() async {
    await _createReview();
    await _noScreenshot.screenshotOn();
    final secureStorage = getIt.get<FlutterSecureStorage>();
    await secureStorage.delete(key: 'roomId');
    await secureStorage.delete(key: 'orderData');
    emit(OrderWaiting());
  }

  _onPickupPassenger() async {
    emit((state as OrderLoaded).copyWith(passengerPickedUp: true));
  }
}
