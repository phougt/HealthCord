import "package:family_health_record/screens/home_screen.dart";
import "package:family_health_record/screens/splash_screen.dart";
import "package:family_health_record/screens/login_screen.dart";
import "package:family_health_record/screens/signup_screen.dart";
import "package:go_router/go_router.dart";

final GoRouter rootRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
      name: 'splashScreen',
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
      name: 'loginScreen',
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      name: 'homeScreen',
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
      name: 'signupScreen',
    ),
  ],
  redirect: (context, state) {
    return null;
  },
  initialLocation: '/',
);
