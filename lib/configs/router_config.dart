import "package:family_health_record/managers/auth_token_manager.dart";
import "package:family_health_record/repositories/auth/auth_repository.dart";
import "package:family_health_record/screens/login_screen.dart";
import "package:family_health_record/screens/signup_screen.dart";
import "package:family_health_record/viewModels/signup_viewmodel.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import '../viewModels/login_viewmodel.dart';

final GoRouter rootRouter = GoRouter(
  routes: <GoRoute>[
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const SplashScreen(),
    //   name: 'splashScreen',
    // ),
    GoRoute(
      path: '/',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (context) {
            return LoginViewModel(
              authRepository: context.read<AuthRepository>(),
              authTokenManager: context.read<AuthTokenManager>(),
            );
          },
          child: const LoginScreen(),
        );
      },
      name: 'loginScreen',
    ),
    // GoRoute(
    //   path: '/home',
    //   builder: (context, state) => const HomeScreen(),
    //   name: 'homeScreen',
    // ),
    GoRoute(
      path: '/signupScreen',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (context) {
            return SignupViewModel(
              authRepository: context.read<AuthRepository>(),
              authTokenManager: context.read<AuthTokenManager>(),
            );
          },
          child: const SignupScreen(),
        );
      },
      name: 'signupScreen',
    ),
  ],
  redirect: (context, state) {
    return null;
  },
  initialLocation: '/',
);
