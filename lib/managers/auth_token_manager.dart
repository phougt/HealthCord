import 'package:family_health_record/models/auth_tokens/auth_token.dart';
import 'package:flutter/widgets.dart';

class AuthTokenManager extends ChangeNotifier {
  AuthToken? _authToken;
  AuthToken? get authToken => _authToken;

  void setAuthToken(AuthToken token) {
    _authToken = token;
    notifyListeners();
  }

  void clearAuthToken() {
    _authToken = null;
    notifyListeners();
  }
}
