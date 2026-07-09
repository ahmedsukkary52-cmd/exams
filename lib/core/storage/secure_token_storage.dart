import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'storage_keys.dart';
import 'token_storage.dart';

@LazySingleton(as: TokenStorage)
class SecureTokenStorage implements TokenStorage {
  final FlutterSecureStorage _storage;

  SecureTokenStorage(this._storage);

  @override
  Future<String?> getAccessToken() {
    return _storage.read(key: StorageKeys.accessToken);
  }

  @override
  Future<void> saveAccessToken(String token) {
    return _storage.write(key: StorageKeys.accessToken, value: token);
  }

  @override
  Future<void> deleteAccessToken() {
    return _storage.delete(key: StorageKeys.accessToken);
  }

  @override
  Future<void> clear() {
    return _storage.deleteAll();
  }
}
