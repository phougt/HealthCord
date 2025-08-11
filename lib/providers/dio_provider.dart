import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './auth_providers.dart';
import '../configs/constant.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final authToken = ref.watch(authTokenProvider).value;

  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  dio.options.headers['Accept'] = 'application/json';

  dio.options.validateStatus = (status) {
    return status! < 500;
  };

  if (authToken != null) {
    dio.options.headers['Authorization'] = 'Bearer ${authToken.accessToken}';
  }

  return dio;
});
