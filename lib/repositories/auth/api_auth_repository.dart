import 'package:dio/dio.dart';
import 'package:family_health_record/utils/api_error.dart';
import './auth_repository.dart';
import '../../models/auth_tokens/auth_token.dart';
import '../../utils/result.dart';

class ApiAuthRepository extends AuthRepository {
  final Dio _dio;
  ApiAuthRepository({required Dio dio}) : _dio = dio;

  @override
  Future<Result<AuthToken>> getFreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'];
        final authToken = AuthToken.fromJson(data);
        return Result.ok(
          data: authToken,
          message: json['message'] ?? 'Token refreshed successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while refreshing the token'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while refreshing the token',
      ),
    );
  }

  @override
  Future<Result<AuthToken>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'];
        final authToken = AuthToken.fromJson(data);
        return Result.ok(
          data: authToken,
          message: json['message'] ?? 'Login successful',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while logging in'),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred during login'),
    );
  }

  @override
  Future<Result<AuthToken>> signup({
    required String username,
    required String password,
    required String confirmPassword,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await _dio.post(
        '/sign-up',
        data: {
          'username': username,
          'password': password,
          'password_confirmation': confirmPassword,
          'email': email,
          'firstname': firstName,
          'lastname': lastName,
        },
      );

      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'];
        final authToken = AuthToken.fromJson(data);
        return Result.ok(
          data: authToken,
          message: json['message'] ?? 'Signup successful',
        );
      } else if (response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while signing up'),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred during signup'),
    );
  }

  @override
  Future<Result<void>> logout() async {
    final response = await _dio.post('/logout');
    if (response.statusCode != 200) {
      return Result.fail(ApiError.fromJson(response.data));
    }

    return Result.ok(data: null, message: 'Logout successful');
  }
}
