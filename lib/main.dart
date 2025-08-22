import 'package:dio/dio.dart';
import 'package:family_health_record/configs/router_config.dart';
import 'package:family_health_record/repositories/auth/api_auth_repository.dart';
import 'package:family_health_record/repositories/auth/auth_repository.dart';
import 'package:family_health_record/repositories/doctor/api_doctor_repository.dart';
import 'package:family_health_record/repositories/doctor/doctor_repository.dart';
import 'package:family_health_record/repositories/group/api_group_repository.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:family_health_record/repositories/hospital/api_hospital_repository.dart';
import 'package:family_health_record/repositories/hospital/hospital_repository.dart';
import 'package:family_health_record/viewModels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'managers/auth_token_manager.dart';
import 'package:family_health_record/configs/constant.dart';
import 'configs/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) {
            return Dio()
              ..options.baseUrl = baseUrl
              ..options.connectTimeout = const Duration(seconds: 10)
              ..options.receiveTimeout = const Duration(seconds: 10)
              ..options.headers['Accept'] = 'application/json'
              ..options.validateStatus = (status) {
                return status != null &&
                    (status >= 200 && status < 300 ||
                        status == 401 ||
                        status == 422);
              };
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return AuthTokenManager(dio: context.read<Dio>())..loadAuthData();
          },
        ),
        ProxyProvider<AuthTokenManager, Dio>(
          create: (context) {
            return Dio()
              ..options.connectTimeout = const Duration(seconds: 10)
              ..options.receiveTimeout = const Duration(seconds: 10)
              ..options.baseUrl = baseUrl
              ..options.headers['Accept'] = 'application/json'
              ..options.validateStatus = (status) {
                return status != null &&
                    (status >= 200 && status < 300 ||
                        status == 401 ||
                        status == 422 ||
                        status == 404 ||
                        status == 400 ||
                        status == 403);
              };
          },
          update: (context, authTokenManager, previous) {
            final dio = previous!;
            dio.options.headers['Authorization'] =
                'Bearer ${authTokenManager.authToken?.accessToken}';
            return dio;
          },
        ),
        Provider<GroupRepository>(
          create: (context) {
            return ApiGroupRepository(dio: context.read<Dio>());
          },
        ),
        Provider<AuthRepository>(
          create: (context) {
            return ApiAuthRepository(dio: context.read<Dio>());
          },
        ),
        Provider<DoctorRepository>(
          create: (context) {
            return ApiDoctorRepository(dio: context.read<Dio>());
          },
        ),
        Provider<HospitalRepository>(
          create: (context) {
            return ApiHospitalRepository(dio: context.read<Dio>());
          },
        ),
        ChangeNotifierProvider(
          create: (context) =>
              HomeViewModel(groupRepository: context.read<GroupRepository>()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HealthCord',
      themeMode: ThemeMode.system,
      darkTheme: MaterialTheme(Typography.blackCupertino).dark(),
      theme: MaterialTheme(Typography.whiteCupertino).light(),
      debugShowCheckedModeBanner: false,
      routerConfig: rootRouter,
    );
  }
}
