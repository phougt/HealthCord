import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

class AuthController extends AutoDisposeAsyncNotifier<void> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  Future<void> build() async {
    ref.onDispose(() {
      usernameController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
      emailController.dispose();
      firstNameController.dispose();
      lastNameController.dispose();
    });

    // This method can be used to initialize any state or perform actions
    // when the controller is first created.
  }

  Future<bool> login() async {
    state = const AsyncValue.loading();

    final repo = ref.read(authRepositoryProvider);
    final username = usernameController.text;
    final password = passwordController.text;

    final result = await repo.login(username, password);

    if (result.isSuccessful) {
      final tokenNotifier = ref.read(authTokenProvider.notifier);
      tokenNotifier.setAuthToken(result.data!);
      state = const AsyncValue.data(null);
      return true;
    } else {
      state = AsyncValue.error(result.error!.toJson(), StackTrace.current);
      return false;
    }
  }

  Future<bool> signup() async {
    state = const AsyncValue.loading();

    final repo = ref.read(authRepositoryProvider);
    final username = usernameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final email = emailController.text;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;

    final result = await repo.signup(
      username: username,
      password: password,
      confirmPassword: confirmPassword,
      email: email,
      firstName: firstName,
      lastName: lastName,
    );

    if (result.isSuccessful) {
      final tokenNotifier = ref.read(authTokenProvider.notifier);
      tokenNotifier.setAuthToken(result.data!);
      state = const AsyncValue.data(null);
      return true;
    } else {
      state = AsyncValue.error(result.error!.toJson(), StackTrace.current);
      return false;
    }
  }

  Future<bool> logout() async {
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.logout();

    if (result.isSuccessful) {
      final tokenNotifier = ref.read(authTokenProvider.notifier);
      tokenNotifier.clearAuthToken();
      state = const AsyncValue.data(null);
      return true;
    } else {
      state = AsyncValue.error(result.error!, StackTrace.current);
      return false;
    }
  }
}
