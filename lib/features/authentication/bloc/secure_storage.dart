import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static SecureStorage? instance;

  factory SecureStorage() =>
      instance ??= SecureStorage._(FlutterSecureStorage());

  SecureStorage._(this._storage);

  final FlutterSecureStorage _storage;
  static const _tokenKey = 'TOKEN';
  static const _emailKey = 'EMAIL';
  // static const _phoneKey = 'PHONE';
  static const _onBordingKey = 'ONBORDING';

  Future<void> persistOnBoard(String first) async {
    await _storage.write(key: _onBordingKey, value: first);
  }

  Future<void> persistEmailAndToken(String email, String token) async {
    await _storage.write(key: _emailKey, value: email);
    await _storage.write(key: _tokenKey, value: token);
  }

  // Future<void> persistPhoneAndToken(String phone, String token) async {
  //   await _storage.write(key: _phoneKey, value: phone);
  //   await _storage.write(key: _tokenKey, value: token);
  // }

  Future<bool> hasToken() async {
    var value = await _storage.read(key: _tokenKey);
    return value != null && value != "";
  }

  Future<bool> hasBoarding() async {
    var value = await _storage.read(key: _onBordingKey);
    return value != null;
  }

  Future<bool> hasEmail() async {
    var value = await _storage.read(key: _emailKey);
    return value != null;
  }

  // Future<bool> hasPhone() async {
  //   var value = await _storage.read(key: _phoneKey);
  //   return value != null;
  // }

  Future<void> deleteToken() async {
    return _storage.delete(key: _tokenKey);
  }

  Future<void> deleteEmail() async {
    return _storage.delete(key: _emailKey);
  }

  // Future<void> deletePhone() async {
  //   return _storage.delete(key: _phoneKey);
  // }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<String?> getEmail() async {
    return _storage.read(key: _emailKey);
  }

  // Future<String?> getPhone() async {
  //   return _storage.read(key: _emailKey);
  // }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
