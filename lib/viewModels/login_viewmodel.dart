import 'package:family_health_record/managers/session_manager.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends ChangeNotifier {
  final SessionManager _sessionManager;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Map<String, dynamic> errors = {};
  bool isLoading = false;

  LoginViewModel({required SessionManager authTokenManager})
    : _sessionManager = authTokenManager;

  Future<bool> login() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final username = usernameController.text;
    final password = passwordController.text;

    final result = await _sessionManager.login(username, password);
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
