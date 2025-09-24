import "package:family_health_record/managers/permission_manager.dart";
import "package:family_health_record/managers/session_manager.dart";
import "package:family_health_record/repositories/auth/auth_repository.dart";
import "package:family_health_record/repositories/doctor/doctor_repository.dart";
import "package:family_health_record/repositories/group/group_repository.dart";
import "package:family_health_record/repositories/group_link/group_link_repository.dart";
import "package:family_health_record/repositories/hospital/hospital_repository.dart";
import "package:family_health_record/repositories/permission/permission_repository.dart";
import "package:family_health_record/repositories/user/user_repository.dart";
import "package:family_health_record/screens/create_doctor_screen.dart";
import "package:family_health_record/screens/create_group_screen.dart";
import "package:family_health_record/screens/create_hospital_screen.dart";
import "package:family_health_record/screens/create_role_screen.dart";
import "package:family_health_record/screens/group_home_screen.dart";
import "package:family_health_record/screens/group_link_screen.dart";
import "package:family_health_record/screens/group_member_screen.dart";
import "package:family_health_record/screens/group_role_permissions_screen.dart";
import "package:family_health_record/screens/group_roles_screen.dart";
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
import "package:family_health_record/viewModels/create_role_viewmodel.dart";
import "package:family_health_record/viewModels/group_home_viewmodel.dart";
import "package:family_health_record/viewModels/group_link_viewmodel.dart";
import "package:family_health_record/viewModels/group_member_viewmodel.dart";
import "package:family_health_record/viewModels/group_role_permissions_viewmodel.dart";
import "package:family_health_record/viewModels/group_roles_viewmodel.dart";
import "package:family_health_record/viewModels/group_setting_viewmodel.dart";
import "package:family_health_record/viewModels/home_viewmodel.dart";
import "package:family_health_record/viewModels/join_group_viewmodel.dart";
import "package:family_health_record/viewModels/login_viewmodel.dart";
import "package:family_health_record/viewModels/medical_entities_viewmodel.dart";
import "package:family_health_record/viewModels/signup_viewmodel.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:image_picker/image_picker.dart";
import "package:provider/provider.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter rootRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      redirect: (context, state) {
        final sessionManager = context.read<SessionManager>();
        if (sessionManager.authToken == null) {
          if (state.matchedLocation == '/' ||
              state.matchedLocation == '/signupScreen') {
            return null;
          }
          return '/';
        }
        return state.matchedLocation;
      },
      builder: (context, state, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) {
                return PermissionManager(
                  userRepository: context.read<UserRepository>(),
                );
              },
            ),
            ChangeNotifierProvider(
              create: (context) {
                return HomeViewModel(
                  groupRepository: context.read<GroupRepository>(),
                );
              },
            ),
          ],
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          name: 'homeScreen',
          builder: (context, state) {
            return const HomeScreen();
          },
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
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            final List<String> routeNames = [
              'groupHomeScreen',
              '',
              'medicalEntitiesScreen',
            ];
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) {
                    return GroupHomeViewModel(
                      permissionManager: context.read<PermissionManager>(),
                      group: (state.extra as Map<String, dynamic>)['group'],
                    )..loadUserPermissions();
                  },
                ),
                ChangeNotifierProvider(
                  lazy: false,
                  create: (context) {
                    return GroupMemberViewModel(
                      groupRepository: context.read<GroupRepository>(),
                      permissionManager: context.read<PermissionManager>(),
                      group: (state.extra as Map<String, dynamic>)['group'],
                    );
                  },
                ),
                ChangeNotifierProvider(
                  lazy: false,
                  create: (context) {
                    return MedicalEntitiesViewModel(
                      doctorRepository: context.read<DoctorRepository>(),
                      hospitalRepository: context.read<HospitalRepository>(),
                      permissionManager: context.read<PermissionManager>(),
                      group: (state.extra as Map<String, dynamic>)['group'],
                    )..refreshEntities();
                  },
                ),
                ChangeNotifierProvider(
                  lazy: false,
                  create: (context) {
                    return GroupLinkViewModel(
                      permissionManager: context.read<PermissionManager>(),
                      groupLinkRepository: context.read<GroupLinkRepository>(),
                      group: (state.extra as Map<String, dynamic>)['group'],
                    )..refreshGroupLinks();
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
                            icon: const Icon(Icons.note_alt_outlined),
                            label: 'Records',
                            selectedIcon: const Icon(Icons.note_alt_rounded),
                          ),
                          NavigationDestination(
                            icon: const Icon(
                              Icons.medical_information_outlined,
                            ),
                            label: 'Entities',
                            selectedIcon: const Icon(
                              Icons.medical_information_rounded,
                            ),
                          ),
                        ],
                        selectedIndex: routeNames.indexOf(
                          GoRouter.of(context).state.name ?? 'groupHomeScreen',
                        ),
                        onDestinationSelected: (index) {
                          context.replaceNamed(routeNames[index]);
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
              path: '/roles',
              name: 'groupRolesScreen',
              builder: (context, state) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) {
                        return GroupRolesViewModel(
                          group: (state.extra as Map<String, dynamic>)['group'],
                          groupRepository: context.read<GroupRepository>(),
                        )..fetchRoles();
                      },
                    ),
                  ],
                  child: const GroupRolesScreen(),
                );
              },
            ),
            GoRoute(
              path: '/rolePermissions',
              name: 'groupRolePermissionsScreen',
              builder: (context, state) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) {
                        return GroupRolePermissionsViewModel(
                          group: (state.extra as Map<String, dynamic>)['group'],
                          role: (state.extra as Map<String, dynamic>)['role'],
                          permissionRepository: context
                              .read<PermissionRepository>(),
                        )..setDefaultSelectedPermissions();
                      },
                    ),
                  ],
                  child: const GroupRolePermissionsScreen(),
                );
              },
            ),
            GoRoute(
              path: '/createRole',
              name: 'createRoleScreen',
              builder: (context, state) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) {
                        return CreateRoleViewModel(
                          permissionRepository: context
                              .read<PermissionRepository>(),
                          group: (state.extra as Map<String, dynamic>)['group'],
                        );
                      },
                    ),
                  ],
                  child: const CreateRoleScreen(),
                );
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
                        return GroupSettingViewModel(
                          permissionManager: context.read<PermissionManager>(),
                          userRepository: context.read<UserRepository>(),
                          authTokenManager: context.read<SessionManager>(),
                          groupRepository: context.read<GroupRepository>(),
                          imagePicker: context.read<ImagePicker>(),
                          group: (state.extra as Map<String, dynamic>)['group'],
                        )..fetchGroupDetails();
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
                        return CreateDoctorViewModel(
                          doctorRepository: context.read<DoctorRepository>(),
                          group: (state.extra as Map<String, dynamic>)['group'],
                        );
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
                        return CreateHospitalViewModel(
                          hospitalRepository: context
                              .read<HospitalRepository>(),
                          group: (state.extra as Map<String, dynamic>)['group'],
                        );
                      },
                    ),
                  ],
                  child: const CreateHospitalScreen(),
                );
              },
            ),
          ],
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
  ],
  initialLocation: '/',
);
