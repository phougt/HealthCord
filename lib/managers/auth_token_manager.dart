import 'package:family_health_record/models/auth_tokens/auth_token.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenManager extends ChangeNotifier {
  AuthToken? _authToken;
  AuthToken? get authToken => _authToken;
  final _secureStorage = FlutterSecureStorage();

  Future<void> setAuthToken(AuthToken token) async {
    await _secureStorage.write(key: 'accessToken', value: token.accessToken);
    await _secureStorage.write(
      key: 'accessTokenExpiry',
      value: token.accessTokenExpiryDate.toIso8601String(),
    );
    _authToken = token;
    notifyListeners();
  }

  Future<void> clearAuthToken() async {
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'accessTokenExpiry');
    _authToken = null;
    notifyListeners();
  }
}
