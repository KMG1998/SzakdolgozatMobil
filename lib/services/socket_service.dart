import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/enums.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/stream_data.dart';

class SocketService {
  final StreamController<StreamData> _dataStream = StreamController();
  final _socket = io(
    'http://10.0.2.2:8085',
    OptionBuilder().disableAutoConnect().setTransports(['websocket']).build(),
  );
  final _logger = Logger();

  final List<String> listenerNames = [
    SocketDataType.driverGeoData.name,
    SocketDataType.driverCancel.name,
    SocketDataType.finishOrder.name,
  ];

  SocketService() {
    _logger.d('create stream service');
    _socket.onConnect((e) => _logger.d('websocket connect ok'));
    _socket.onError((e) {
      _logger.e('error: $e');
      if (!_socket.connected) {
        _socket.connect();
      }
    });
    _socket.onDisconnect((e) => _logger.d('disconnect for $e'));
    _socket.onclose((e) => _logger.d('closed for $e'));
    _socket.connect();
  }

  void connectToRoom(String roomId, void Function() onDriverCancel, void Function() onOrderFinish) {
    _socket.emit(SocketDataType.joinRoom.name, roomId);
    _socket.on(SocketDataType.driverGeoData.name, (data) async {
      try {
        final streamData = StreamData.fromJson(jsonDecode(data));
        _logger.d(streamData);
      } catch (e) {
        _logger.e(e);
      }
    });
    _socket.on(SocketDataType.finishOrder.name, (data) {
      onOrderFinish();
      _socket.emit(SocketDataType.leaveRoom.name, roomId);
      disconnectRoom();
    });
    _socket.on(SocketDataType.driverCancel.name, (data) {
      _logger.e('recieved driver cancel');
      onDriverCancel();
      _socket.emit(SocketDataType.leaveRoom.name, roomId);
      disconnectRoom();
    });
  }

  Stream getStream() {
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
}
