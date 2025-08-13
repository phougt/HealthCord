import 'package:family_health_record/viewmodels/signup_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignupViewModel>();
    final errors = viewModel.errors['errors'] ?? {};
    final message = viewModel.errors['message'] ?? '';

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
                      TextField(
                        controller: viewModel.confirmPasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          errorText: errors['password_confirmation']?[0]
                              .toString(),
                        ),
                        obscureText: true,
                      ),
                      TextField(
                        controller: viewModel.emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          errorText: errors['email']?[0].toString(),
                        ),
                      ),
                      TextField(
                        controller: viewModel.firstnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                          errorText: errors['firstname']?[0].toString(),
                        ),
                      ),
                      TextField(
                        controller: viewModel.lastnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Last Name',
                          errorText: errors['lastname']?[0].toString(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: () async {
                          if (viewModel.isLoading) return;
                          final success = await viewModel.signup();
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
