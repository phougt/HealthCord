import 'package:family_health_record/viewModels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    final Map<String, dynamic> errors = viewModel.errors['errors'] ?? {};
    final message = viewModel.errors['message'] ?? '';

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
                    Icons.note_add_rounded,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    "HealthCord",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    "Record your health records with ease",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: viewModel.usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      errorText: errors['username']?[0].toString(),
                    ),
                  ),
                  TextField(
                    controller: viewModel.passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      errorText: errors['password']?[0].toString(),
                    ),
                    obscureText: true,
                  ),
                  if (message.isNotEmpty && errors.isEmpty)
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async {
                      if (viewModel.isLoading) return;
                      if (await viewModel.login()) {
                        if (context.mounted) {
                          context.goNamed('homeScreen');
                        }
                      }
                    },
                    child: viewModel.isLoading
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
