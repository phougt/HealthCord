import 'package:dio/dio.dart';
import 'package:family_health_record/models/user/user.dart';
import 'package:family_health_record/repositories/user/user_repository.dart';
import 'package:family_health_record/utils/api_error.dart';
import 'package:family_health_record/utils/result.dart';

class ApiUserRepository extends UserRepository {
  final Dio _dio;
  ApiUserRepository({required Dio dio}) : _dio = dio;

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      final response = await _dio.get('/user');
      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'];
        final user = User.fromJson(data);
        return Result.ok(
          data: user,
          message: json['message'] ?? 'User fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Future.value(
        Result.fail(ApiError(message: 'An error occurred while fetching user')),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred while fetching user'),
    );
  }
}
