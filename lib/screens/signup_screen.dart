import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_providers.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authViewModelProvider);

    final stateError = state.error as Map<String, dynamic>? ?? {};
    final errors = stateError['errors'] as Map<String, dynamic>? ?? {};

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10,
                    children: [
                      Icon(Icons.person_add, size: 100),
                      Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: ref
                            .read(authViewModelProvider.notifier)
                            .usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          errorText: errors['username']?[0].toString(),
                        ),
                      ),
                      TextField(
                        controller: ref
                            .read(authViewModelProvider.notifier)
                            .passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          errorText: errors['password']?[0].toString(),
                        ),
                        obscureText: true,
                      ),
                      TextField(
                        controller: ref
                            .read(authViewModelProvider.notifier)
                            .confirmPasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          errorText: errors['password_confirmation']?[0]
                              .toString(),
                        ),
                        obscureText: true,
                      ),
                      TextField(
                        controller: ref
                            .read(authViewModelProvider.notifier)
                            .emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          errorText: errors['email']?[0].toString(),
                        ),
                      ),
                      TextField(
                        controller: ref
                            .read(authViewModelProvider.notifier)
                            .firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                          errorText: errors['firstname']?[0].toString(),
                        ),
                      ),
                      TextField(
                        controller: ref
                            .read(authViewModelProvider.notifier)
                            .lastNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Last Name',
                          errorText: errors['lastname']?[0].toString(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: () async {
                          if (state.isLoading) return;

                          if (await ref
                              .read(authViewModelProvider.notifier)
                              .signup()) {
                            if (!context.mounted) return;
                            context.goNamed('splashScreen');
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
