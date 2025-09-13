import "package:family_health_record/managers/session_manager.dart";
import "package:family_health_record/managers/permission_manager.dart";
import "package:family_health_record/repositories/auth/auth_repository.dart";
import "package:family_health_record/repositories/group/group_repository.dart";
import "package:family_health_record/repositories/doctor/doctor_repository.dart";
import "package:family_health_record/repositories/group_link/group_link_repository.dart";
import "package:family_health_record/repositories/hospital/hospital_repository.dart";
import "package:family_health_record/repositories/user/user_repository.dart";
import "package:family_health_record/screens/create_doctor_screen.dart";
import "package:family_health_record/screens/create_group_screen.dart";
import "package:family_health_record/screens/create_hospital_screen.dart";
import "package:family_health_record/screens/group_home_screen.dart";
import "package:family_health_record/screens/group_link_screen.dart";
import "package:family_health_record/screens/group_member_screen.dart";
import "package:family_health_record/screens/group_setting_screen.dart";
import "package:family_health_record/screens/home_screen.dart";
import "package:family_health_record/screens/join_group_screen.dart";
import "package:family_health_record/screens/login_screen.dart";
import "package:family_health_record/screens/medical_entities_screen.dart";
import "package:family_health_record/screens/signup_screen.dart";
import "package:family_health_record/screens/splash_screen.dart";
import "package:family_health_record/viewModels/create_doctor_viewmodel.dart";
import 'package:family_health_record/viewModels/create_group_viewmodel.dart';
import "package:family_health_record/viewModels/create_hospital_viewmodel.dart";
import "package:family_health_record/viewModels/group_home_viewmodel.dart";
import "package:family_health_record/viewModels/group_link_viewmodel.dart";
import "package:family_health_record/viewModels/group_member_viewmodel.dart";
import "package:family_health_record/viewModels/group_setting_viewmodel.dart";
import "package:family_health_record/viewModels/join_group_viewmodel.dart";
import "package:family_health_record/viewModels/medical_entities_viewmodel.dart";
import "package:family_health_record/viewModels/signup_viewmodel.dart";
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
          'medicalEntitiesScreen',
          'groupMembersScreen',
        ];
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) {
                final groupHomeViewModel = GroupHomeViewModel(
                  permissionManager: context.read<PermissionManager>(),
                );

                if (state.extra is Map<String, dynamic>) {
                  groupHomeViewModel.groupId =
                      (state.extra as Map<String, dynamic>)['groupId'];
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
                  permissionManager: context.read<PermissionManager>(),
                );

                if (state.extra is Map<String, dynamic>) {
                  viewModel.groupId =
                      (state.extra as Map<String, dynamic>)['groupId'];
                  viewModel.refreshGroupMembers();
                }

                return viewModel;
              },
            ),
            ChangeNotifierProvider(
              lazy: false,
              create: (context) {
                final viewModel = MedicalEntitiesViewModel(
                  doctorRepository: context.read<DoctorRepository>(),
                  hospitalRepository: context.read<HospitalRepository>(),
                  permissionManager: context.read<PermissionManager>(),
                );
                if (state.extra is Map<String, dynamic>) {
                  viewModel.groupId =
                      (state.extra as Map<String, dynamic>)['groupId'];
                  viewModel.refreshEntities();
                }

                return viewModel;
              },
            ),
            ChangeNotifierProvider(
              lazy: false,
              create: (context) {
                final viewModel = GroupLinkViewModel(
                  permissionManager: context.read<PermissionManager>(),
                  groupLinkRepository: context.read<GroupLinkRepository>(),
                );

                if (state.extra is Map<String, dynamic>) {
                  viewModel.groupId =
                      (state.extra as Map<String, dynamic>)['groupId'];
                  viewModel.refreshGroupLinks();
                }

                return viewModel;
              },
            ),
          ],
          child: Scaffold(
            body: child,
            bottomNavigationBar:
                routeNames.contains(GoRouter.of(context).state.name ?? '')
                ? NavigationBar(
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
                        selectedIcon: const Icon(
                          Icons.medical_information_rounded,
                        ),
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
                      context.goNamed(routeNames[index]);
                    },
                  )
                : null,
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/groupLink',
          name: 'groupLinkScreen',
          builder: (context, state) {
            return const GroupLinkScreen();
          },
        ),
        GoRoute(
          path: '/groupSetting',
          name: 'groupSettingScreen',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                Provider<ImagePicker>(create: (context) => ImagePicker()),
                ChangeNotifierProvider(
                  create: (context) {
                    final viewModel = GroupSettingViewModel(
                      permissionManager: context.read<PermissionManager>(),
                      userRepository: context.read<UserRepository>(),
                      authTokenManager: context.read<SessionManager>(),
                      groupRepository: context.read<GroupRepository>(),
                      imagePicker: context.read<ImagePicker>(),
                    );

                    if (state.extra is Map<String, dynamic>) {
                      viewModel.groupId =
                          (state.extra as Map<String, dynamic>)['groupId'];
                      viewModel.fetchGroupDetails();
                    }

                    return viewModel;
                  },
                ),
              ],
              child: const GroupSettingScreen(),
            );
          },
        ),
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
        GoRoute(
          path: '/medicalEntities',
          name: 'medicalEntitiesScreen',
          builder: (context, state) {
            return const MedicalEntitiesScreen();
          },
        ),
        GoRoute(
          path: '/createDoctor',
          name: 'createDoctorScreen',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) {
                    final viewModel = CreateDoctorViewModel(
                      doctorRepository: context.read<DoctorRepository>(),
                    );

                    if (state.extra is Map<String, dynamic>) {
                      viewModel.groupId =
                          (state.extra as Map<String, dynamic>)['groupId'];
                    }

                    return viewModel;
                  },
                ),
              ],
              child: const CreateDoctorScreen(),
            );
          },
        ),
        GoRoute(
          path: '/createHospital',
          name: 'createHospitalScreen',
          builder: (context, state) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) {
                    final viewModel = CreateHospitalViewModel(
                      hospitalRepository: context.read<HospitalRepository>(),
                    );

                    if (state.extra is Map<String, dynamic>) {
                      viewModel.groupId =
                          (state.extra as Map<String, dynamic>)['groupId'];
                    }

                    return viewModel;
                  },
                ),
              ],
              child: const CreateHospitalScreen(),
            );
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
              authTokenManager: context.read<SessionManager>(),
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
              authTokenManager: context.read<SessionManager>(),
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
    final sessionManager = context.read<SessionManager>();
    if (sessionManager.authToken == null) {
      if (state.matchedLocation == '/') return null;
      return '/login';
    }
    return state.matchedLocation;
  },
  initialLocation: '/',
);
