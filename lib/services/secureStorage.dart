import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _androidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  final _storage = FlutterSecureStorage(
    aOptions: _androidOptions,
  );

  Future<String?> getValue(String key) async {
    return await _storage.read(key: key, aOptions: _androidOptions);
  }

  Future<void> setValue(String key, String value) async {
    await _storage.write(key: key, value: value, aOptions: _androidOptions);
  }
}
