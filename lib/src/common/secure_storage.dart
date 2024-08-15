import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  final String _keyJwtToken = 'jwtToken';

  Future writeJwtToken(String jwtToken) async {
    await deleteJwtToken(); // have to delete token first
    await _storage.write(key: _keyJwtToken, value: jwtToken);
  }

  Future<String?> readJwtToken() async {
    try {
      return await _storage.read(key: _keyJwtToken);
    } catch (e) {
      if (kDebugMode) {
        print('Error reading jwt token in secureStorage: $e');
      }
      return null;
    }
  }

  Future deleteJwtToken() async {
    return await _storage.delete(key: _keyJwtToken);
  }
}
