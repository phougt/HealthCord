import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authTokenManager = context.watch<AuthTokenManager>();
    if (authTokenManager.isFinishedLoading) {
      if (authTokenManager.authToken != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.goNamed('homeScreen');
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.goNamed('loginScreen');
        });
      }
    }

    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
