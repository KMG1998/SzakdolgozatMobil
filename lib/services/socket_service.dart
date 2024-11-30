import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/enums.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/StreamData.dart';

class SocketService {
  final StreamController<StreamData> _dataStream = StreamController();
  final _socket = io(
    'http://10.0.2.2:8085',
    OptionBuilder().disableAutoConnect().setTransports(['websocket']).build(),
  );
  final _logger = Logger();

  final List<String> listenerNames = [SocketDataType.driverGeoData.name, SocketDataType.driverCancel.name];

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

  void connectToRoom(String roomId, void Function() onDriverCancel) {
    _socket.emit(SocketDataType.joinRoom.name, roomId);
    _socket.on(SocketDataType.driverGeoData.name, (data) async {
      try {
        final streamData = StreamData.fromJson(jsonDecode(data));
        _logger.d(streamData);
      } catch (e) {
        _logger.e(e);
      }
    });
    _socket.on(SocketDataType.driverCancel.name, (data) {
      onDriverCancel();
      _logger.d('driver cancel');
      _socket.emit(SocketDataType.leaveRoom.name, roomId);
    });
  }

  Stream getStream() {
    return _dataStream.stream;
  }

  void emitData(SocketDataType emitType, StreamData data) async {
    final token = await getIt.get<FlutterSecureStorage>().read(key: 'token');
    final roomId = await getIt.get<FlutterSecureStorage>().read(key: 'roomId');
    _logger.d('the feckin room id is $roomId');
    _logger.d('the feckin token id is $token');
    _socket.emit(
      emitType.name,
      jsonEncode(
        {'userToken': token, 'roomId': roomId, 'streamData': jsonEncode(data)},
      ),
    );
  }

  void disconnectChannel() {
    try {
      _socket.off('dataTransfer');
      _logger.d(_socket.listenersAny());
      for (String listenerName in listenerNames) {
        _socket.off(listenerName);
      }
      getIt.get<FlutterSecureStorage>().delete(key: 'roomId');
    } catch (e) {
      _logger.e('disconnect error $e');
    }
  }
}
