import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/enums.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/popups/order_review_dialog.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
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
        Fluttertoast.showToast(msg: 'Nincs elérhető sofőr');
        emit(OrderError(errorMessage: 'Nincs elérhető sofőr'));
        return;
      }
      _logger.d(offerResp.routes);
      var currentRoute = PolylinePoints().decodePolyline(offerResp.routes[0].overviewPolyline!.points!);
      await getIt.get<FlutterSecureStorage>().write(key: 'roomId', value: offerResp.socketRoomId);
      getIt.get<SocketService>().connectToRoom(offerResp.socketRoomId, _onDriverCancel,_onOrderFinish);
      emit(
          OrderLoaded(vehicleData: offerResp.vehicleData, currentPassengerPos: currentPos, currentRoute: currentRoute));
    } catch (e) {
      _logger.e(e);
      emit(OrderError(errorMessage: 'UNKNOWN ERROR'));
    }
  }

  cancelRide() async {
    try {
      emit(OrderLoading());
      await getIt.get<SocketService>().emitData(SocketDataType.passengerCancel, StreamData(data: ''));
      getIt.get<SocketService>().disconnectRoom();
      emit(OrderInit());
    } catch (e) {
      _logger.e(e);
    }
  }

  _createReview() async {
    OrderReview? newReview;
    await showDialog<OrderReview?>(context: navigatorKey.currentContext!, builder: (ctx) => OrderReviewDialog()).then((value) => {
      newReview = value
    });
    if(newReview != null){
      final success = await getIt.get<ReviewService>().createReview(score: newReview!.score,reviewText: newReview!.reviewText);
      if(success){
        Fluttertoast.showToast(msg: 'Sikeres értékelés');
      }
    }
  }

  _onDriverCancel() {
    emit(OrderInit(error: 'A sofőr visszautasította'));

  }
  _onOrderFinish() async{
    await _createReview();
    emit(OrderInit());
  }
}
