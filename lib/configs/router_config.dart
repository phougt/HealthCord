import "package:family_health_record/managers/auth_token_manager.dart";
import "package:family_health_record/repositories/auth/auth_repository.dart";
import "package:family_health_record/repositories/group/group_repository.dart";
import "package:family_health_record/screens/create_group_screen.dart";
import "package:family_health_record/screens/home_screen.dart";
import "package:family_health_record/screens/join_group_screen.dart";
import "package:family_health_record/screens/login_screen.dart";
import "package:family_health_record/screens/signup_screen.dart";
import "package:family_health_record/screens/splash_screen.dart";
import 'package:family_health_record/viewModels/create_group_viewmodel.dart';
import "package:family_health_record/viewModels/join_group_viewmodel.dart";
import "package:family_health_record/viewmodels/signup_viewmodel.dart";
import "package:go_router/go_router.dart";
import "package:image_picker/image_picker.dart";
import "package:provider/provider.dart";
import "package:family_health_record/viewModels/login_viewmodel.dart";

final GoRouter rootRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
      name: 'splashScreen',
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (context) {
            return LoginViewModel(
              authTokenManager: context.read<AuthTokenManager>(),
            );
          },
          child: LoginScreen(),
        );
      },
      name: 'loginScreen',
    ),
    GoRoute(
      path: '/home',
      name: 'homeScreen',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
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
    GoRoute(
      path: '/createGroup',
      builder: (context, state) {
        return MultiProvider(
          providers: [
            Provider<ImagePicker>(create: (context) => ImagePicker()),
            ChangeNotifierProvider(
              create: (context) {
                return CreateGroupViewModel(
                  imagePicker: context.read<ImagePicker>(),
                  groupRepository: context.read<GroupRepository>(),
                );
              },
            ),
          ],
          child: const CreateGroupScreen(),
        );
      },
      name: 'createGroupScreen',
    ),
    GoRoute(
      path: '/joinGroup',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (context) {
            return JoinGroupViewModel(
              groupRepository: context.read<GroupRepository>(),
            );
          },
          child: const JoinGroupScreen(),
        );
      },
      name: 'joinGroupScreen',
    ),
  ],
  redirect: (context, state) {
    return null;
  },
  initialLocation: '/',
);
