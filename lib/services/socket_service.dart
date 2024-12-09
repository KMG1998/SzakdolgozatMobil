import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/enums.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/stream_data.dart';

class SocketService {
  static final _socket = io(
    'http://10.0.2.2:8085',
    OptionBuilder().disableAutoConnect().setTransports(['websocket']).build(),
  );

  final StreamController<LatLng> _dataStream = BehaviorSubject();
  final _backgroundService = FlutterBackgroundService();

  final List<String> listenerNames = [
    SocketDataType.driverGeoData.name,
    SocketDataType.driverCancel.name,
    SocketDataType.finishOrder.name,
  ];

  final _logger = Logger();

  SocketService() {
    _logger.d('create stream service');
    _backgroundService.configure(
        iosConfiguration: IosConfiguration(
          autoStart: false,
          onForeground: onStart,
          onBackground: onIosBackground,
        ),
        androidConfiguration: AndroidConfiguration(
          autoStart: false,
          onStart: onStart,
          isForegroundMode: true,
          autoStartOnBoot: false,
        ));
    _logger.d('BS configured');
    _socket.onConnect((e) => _logger.d('websocket connect ok'));
    _socket.onError((e) {
      _logger.e('error: $e');
      if (!_socket.connected) {
        _socket.connect();
      }
    });
    _socket.onDisconnect((e) {
      _logger.d('disconnect for $e');
    });
    _socket.onclose((e) {
      _logger.d('closed for $e');
      getIt.get<FlutterSecureStorage>().delete(key: 'roomId');
      getIt.get<FlutterSecureStorage>().delete(key: 'orderData');
      getIt.get<FlutterSecureStorage>().delete(key: 'passengerPickedUp');
    });
    _socket.connect();
  }

  void connectToRoom({
    required String roomId,
    required void Function() onDriverCancel,
    required void Function() onOrderFinish,
    required void Function() onPickupPassenger,
  }) {
    _socket.emit(SocketDataType.joinRoom.name, roomId);
    _socket.on(SocketDataType.driverGeoData.name, (data) async {
      try {
        _dataStream.add(LatLng(data[0], data[1]));
      } catch (e) {
        _logger.e(e);
      }
    });
    _socket.on(SocketDataType.finishOrder.name, (data) {
      onOrderFinish();
      _socket.emit(SocketDataType.leaveRoom.name, roomId);
      disconnectRoom();
    });
    _socket.on(SocketDataType.pickUpPassenger.name, (data) {
      onPickupPassenger();
    });
    _socket.on(SocketDataType.driverCancel.name, (data) {
      _logger.e('received driver cancel');
      onDriverCancel();
      _socket.emit(SocketDataType.leaveRoom.name, roomId);
      disconnectRoom();
    });
  }

  Stream<LatLng> getStream() {
    return _dataStream.stream;
  }

  Future<void> emitData(SocketDataType emitType, StreamData data) async {
    final token = await getIt.get<FlutterSecureStorage>().read(key: 'token');
    final roomId = await getIt.get<FlutterSecureStorage>().read(key: 'roomId');
    _socket.emit(
      emitType.name,
      jsonEncode(
        {'userToken': token, 'roomId': roomId, 'streamData': jsonEncode(data)},
      ),
    );
  }

  void disconnectRoom() {
    try {
      for (String listenerName in listenerNames) {
        _socket.off(listenerName);
      }
      getIt.get<FlutterSecureStorage>().delete(key: 'roomId');
    } catch (e) {
      _logger.e('disconnect error $e');
    }
  }

  void startBackgroundService() async {
    await _backgroundService.startService();
  }

  void stopBackgroundService() {
    _backgroundService.invoke('stop');
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) {
    DartPluginRegistrant.ensureInitialized;
    WidgetsFlutterBinding.ensureInitialized();
    initServiceLocator();
    service.on('stop').listen((event) {
      service.stopSelf();
    });
    _socket.connect();
  }

  @pragma('vm:entry-point')
  Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }
}
