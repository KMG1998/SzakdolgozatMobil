import 'dart:async';
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/enums.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/StreamData.dart';

class SocketService {
  final StreamController<StreamData> _dataStream = StreamController();
  String _currentRoomId = '';
  final _socket = io('http://10.0.2.2:8085', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false
  });
  final _logger = Logger();

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

  void connectToRoom(String channelId) {
    _currentRoomId = channelId;
    _logger.d(_currentRoomId);
    _socket.emit(StreamDataType.joinRoom.name, _currentRoomId);
    _socket.on(StreamDataType.driverGeoData.name, (data) async {
      try {
        final streamData = StreamData.fromJson(jsonDecode(data));
        _logger.d(streamData);
      } catch (e) {
        _logger.e(e);
      }
    });
  }

  Stream getStream() {
    return _dataStream.stream;
  }

  String getCurrentChannelId() {
    return _currentRoomId;
  }

  void emitData(StreamData data) {
    _socket.emit(
      data.dataType.name,
      jsonEncode(
        {'roomId': _currentRoomId, 'streamData': jsonEncode(data)},
      ),
    );
  }

  void disconnectChannel() {
    try {
      _socket.off('dataTransfer');
      _logger.d(_socket.listenersAny());
      _currentRoomId = '';
    } catch (e) {
      _logger.e('disconnect error $e');
    }
  }
}
