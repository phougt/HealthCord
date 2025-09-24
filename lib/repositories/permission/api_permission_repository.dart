import 'package:dio/dio.dart';
import 'package:family_health_record/models/permissions/permission.dart';
import 'package:family_health_record/repositories/permission/permission_repository.dart';
import 'package:family_health_record/utils/api_error.dart';
import 'package:family_health_record/utils/result.dart';

class ApiPermissionRepository implements PermissionRepository {
  final Dio _dio;

  ApiPermissionRepository({required Dio dio}) : _dio = dio;

  @override
  Future<Result<List<Permission>>> getPermissions() async {
    try {
      final response = await _dio.get('/permission');
      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'] as List;
        final permissions = data.map((e) => Permission.fromJson(e)).toList();
        return Result.ok(
          data: permissions,
          message: 'Permissions fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while fetching permissions'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while fetching permissions',
      ),
    );
  }

  @override
  Future<Result<void>> updateRolePermissions({
    required int roleId,
    required Iterable<int> permissionIds,
  }) async {
    try {
      final response = await _dio.post(
        '/group-role/$roleId/permission',
        data: {'role_id': roleId, 'permission_ids': permissionIds.toList()},
      );
      if (response.statusCode == 200) {
        return Result.ok(
          data: null,
          message: 'Permissions fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while fetching permissions'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while fetching permissions',
      ),
    );
  }

  @override
  Future<Result<List<Permission>>> getRolePermissions({
    required int roleId,
  }) async {
    try {
      final response = await _dio.get('/group-role/$roleId/permission');
      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'] as List;
        final permissions = data.map((e) => Permission.fromJson(e)).toList();
        return Result.ok(
          data: permissions,
          message: 'Permissions fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while fetching permissions'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while fetching permissions',
      ),
    );
  }
}
