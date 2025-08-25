import 'package:dio/dio.dart';
import 'package:family_health_record/models/roles/role.dart';
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
      return Result.fail(
        ApiError(message: 'An error occurred while fetching user'),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred while fetching user'),
    );
  }

  @override
  Future<Result<void>> leaveGroup(int groupId) async {
    try {
      final response = await _dio.delete('/user/group/$groupId');
      if (response.statusCode == 200) {
        final json = response.data;
        return Result.ok(
          data: null,
          message: json['message'] ?? 'Left group successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while leaving group'),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred while leaving group'),
    );
  }

  @override
  Future<Result<Role>> getCurrentUserRole(int groupId) async {
    try {
      final response = await _dio.get('/user/group/$groupId/group-role');
      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'];
        final role = Role.fromJson(data);
        return Result.ok(
          data: role,
          message: json['message'] ?? 'User role fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while fetching user role'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while fetching user role',
      ),
    );
  }

  @override
  Future<Result<List<String>>> getCurrentUserGroupPermissions(
    int groupId,
  ) async {
    try {
      final response = await _dio.get('/user/group/$groupId/permission');
      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'];
        final permissions = List<String>.from(data);
        return Result.ok(
          data: permissions,
          message: json['message'] ?? 'User permissions fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while fetching user permissions'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while fetching user permissions',
      ),
    );
  }
}
