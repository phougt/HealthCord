import 'package:family_health_record/managers/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionManager = context.watch<SessionManager>();
    if (sessionManager.isFinishedLoading) {
      if (sessionManager.authToken != null) {
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
