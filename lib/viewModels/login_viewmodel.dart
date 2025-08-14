import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthTokenManager _authTokenManager;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Map<String, dynamic> errors = {};
  bool isLoading = false;

  LoginViewModel({required AuthTokenManager authTokenManager})
    : _authTokenManager = authTokenManager;

  Future<bool> login() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final username = usernameController.text;
    final password = passwordController.text;

    final result = await _authTokenManager.login(username, password);
    if (result.isSuccessful) {
      isLoading = false;
      notifyListeners();
      return true;
    }
    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
