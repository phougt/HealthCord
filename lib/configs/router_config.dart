import "package:family_health_record/managers/auth_token_manager.dart";
import "package:family_health_record/repositories/auth/auth_repository.dart";
import "package:family_health_record/repositories/group/group_repository.dart";
import "package:family_health_record/screens/create_group_screen.dart";
import "package:family_health_record/screens/group_home_screen.dart";
import "package:family_health_record/screens/group_member_screen.dart";
import "package:family_health_record/screens/home_screen.dart";
import "package:family_health_record/screens/join_group_screen.dart";
import "package:family_health_record/screens/login_screen.dart";
import "package:family_health_record/screens/signup_screen.dart";
import "package:family_health_record/screens/splash_screen.dart";
import 'package:family_health_record/viewModels/create_group_viewmodel.dart';
import "package:family_health_record/viewModels/group_home_viewmodel.dart";
import "package:family_health_record/viewModels/group_member_viewmodel.dart";
import "package:family_health_record/viewModels/join_group_viewmodel.dart";
import "package:family_health_record/viewmodels/signup_viewmodel.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:image_picker/image_picker.dart";
import "package:provider/provider.dart";
import "package:family_health_record/viewModels/login_viewmodel.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter rootRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        final List<String> routeNames = [
          'groupHomeScreen',
          '',
          '',
          'groupMembersScreen',
        ];
        final routeDecorationsNames = [
          'Group Home',
          'Health Records',
          'Medical Entities',
          'Group Members',
        ];
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) {
                final groupHomeViewModel = GroupHomeViewModel(
                  authTokenManager: context.read<AuthTokenManager>(),
                );

                if (state.extra is int) {
                  groupHomeViewModel.groupId = state.extra as int;
                  groupHomeViewModel.loadUserPermissions();
                }

                return groupHomeViewModel;
              },
            ),
            ChangeNotifierProvider(
              lazy: false,
              create: (context) {
                final viewModel = GroupMemberViewModel(
                  groupRepository: context.read<GroupRepository>(),
                  authTokenManager: context.read<AuthTokenManager>(),
                );

                if (state.extra is int) {
                  viewModel.groupId = state.extra as int;
                  viewModel.refreshGroupMembers();
                }

                return viewModel;
              },
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                routeDecorationsNames[routeNames.indexOf(
                  GoRouter.of(context).state.name ?? 'groupHomeScreen',
                )],
              ),
            ),
            body: child,
            bottomNavigationBar: NavigationBar(
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  label: 'Home',
                  selectedIcon: const Icon(Icons.home_filled),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.book_outlined),
                  label: 'Records',
                  selectedIcon: const Icon(Icons.book_rounded),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.medical_information_outlined),
                  label: 'Medical Entities',
                  selectedIcon: const Icon(Icons.medical_information_rounded),
                ),
                NavigationDestination(
                  icon: const Icon(Icons.people_alt_outlined),
                  label: 'Members',
                  selectedIcon: const Icon(Icons.people_alt_rounded),
                ),
              ],
              selectedIndex: routeNames.indexOf(
                GoRouter.of(context).state.name ?? 'groupHomeScreen',
              ),
              onDestinationSelected: (index) {
                context.pushNamed(routeNames[index]);
              },
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/groupHome',
          name: 'groupHomeScreen',
          builder: (context, state) {
            return const GroupHomeScreen();
          },
        ),
        GoRoute(
          path: '/groupMembers',
          name: 'groupMembersScreen',
          builder: (context, state) {
            return const GroupMemberScreen();
          },
        ),
      ],
    ),
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
