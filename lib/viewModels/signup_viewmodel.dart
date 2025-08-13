import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:family_health_record/repositories/auth/auth_repository.dart';
import 'package:flutter/widgets.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final AuthTokenManager _authTokenManager;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  Map<String, dynamic> errors = {};
  bool isLoading = false;

  SignupViewModel({
    required AuthRepository authRepository,
    required AuthTokenManager authTokenManager,
  }) : _authRepository = authRepository,
       _authTokenManager = authTokenManager;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    super.dispose();
  }

  Future<bool> signup() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final username = usernameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final email = emailController.text;
    final firstName = firstnameController.text;
    final lastName = lastnameController.text;

    final result = await _authRepository.signup(
      username: username,
      password: password,
      confirmPassword: confirmPassword,
      email: email,
      firstName: firstName,
      lastName: lastName,
    );

    if (result.isSuccessful) {
      _authTokenManager.setAuthToken(result.data!);
      isLoading = false;
      notifyListeners();
      return true;
    }
    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }
}
