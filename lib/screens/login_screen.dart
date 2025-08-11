import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController = ref.watch(authControllerProvider.notifier);
    final state = ref.watch(authControllerProvider);

    final stateError = state.error as Map<String, dynamic>? ?? {};
    final errors = stateError['errors'] as Map<String, dynamic>? ?? {};

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10,
                children: [
                  Icon(
                    Icons.book,
                    size: 100,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    "HealthCord",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Record your health records with ease",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: loginController.usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      errorText: errors['username']?[0].toString(),
                    ),
                  ),
                  TextField(
                    controller: loginController.passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      errorText: errors['password']?[0].toString(),
                    ),
                    obscureText: true,
                  ),
                  if (stateError['message'] != null && errors.isEmpty)
                    Text(
                      stateError['message'].toString(),
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async {
                      if (state.isLoading) return;
                      loginController.login();
                    },
                    child: state.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Text('Login'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      context.pushNamed('signupScreen');
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
