// import 'package:family_health_record/screens/home_screen.dart';
// import 'package:family_health_record/screens/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_providers.dart';

// class SplashScreen extends ConsumerWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authTokenProviderValue = ref.watch(authTokenProvider);

//     return authTokenProviderValue.when(
//       data: (authToken) {
//         if (authToken == null) {
//           return const LoginScreen();
//         } else {
//           return const HomeScreen();
//         }
//       },
//       error: (error, stackTrace) {
//         return Scaffold(body: Center(child: CircularProgressIndicator()));
//       },
//       loading: () {
//         return Scaffold(body: Center(child: CircularProgressIndicator()));
//       },
//     );
//   }
// }
