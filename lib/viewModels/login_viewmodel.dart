import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:family_health_record/repositories/auth/auth_repository.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final AuthTokenManager _authTokenManager;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Map<String, dynamic> errors = {};
  bool isLoading = false;

  LoginViewModel({
    required AuthRepository authRepository,
    required AuthTokenManager authTokenManager,
  }) : _authTokenManager = authTokenManager,
       _authRepository = authRepository;

  Future<bool> login() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final username = usernameController.text;
    final password = passwordController.text;

    final result = await _authRepository.login(username, password);
    if (result.isSuccessful) {
      await _authTokenManager.setAuthToken(result.data!);
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
