import 'package:family_health_record/models/user/user.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:family_health_record/utils/api_error.dart';

class ApiGroupRepository extends GroupRepository {
  final Dio _dio;
  ApiGroupRepository({required Dio dio}) : _dio = dio;

  @override
  Future<Result<List<Group>>> getGroupsWithPagination(
    int perPage,
    int page,
  ) async {
    try {
      final response = await _dio.get(
        '/group',
        queryParameters: {'per_page': perPage, 'page': page},
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'] as List;
        final groups = data.map((e) => Group.fromJson(e)).toList();
        return Result.ok(
          data: groups,
          message: json['message'] ?? 'Groups fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Future.value(
        Result.fail(
          ApiError(message: 'An error occurred while fetching groups'),
        ),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred while fetching groups'),
    );
  }

  @override
  Future<Result<Group>> getGroupDetails(int groupId) async {
    try {
      final response = await _dio.get('/group/$groupId');
      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'];
        final group = Group.fromJson(data);
        return Result.ok(
          data: group,
          message: json['message'] ?? 'Group details fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Future.value(
        Result.fail(
          ApiError(message: 'An error occurred while fetching group details'),
        ),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while fetching group details',
      ),
    );
  }

  @override
  Future<Result<Group>> createGroup({
    required String name,
    String? description,
    String? groupProfile,
  }) async {
    try {
      final dio = _dio.clone();
      dio.options.headers['Content-Type'] = 'multipart/form-data';

      final formData = FormData.fromMap({
        'name': name,
        'description': description,
        'group_profile': groupProfile != null
            ? await MultipartFile.fromFile(groupProfile)
            : null,
      });

      final response = await dio.post('/group', data: formData);

      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'];
        final createdGroup = Group.fromJson(data);
        return Result.ok(
          data: createdGroup,
          message: json['message'] ?? 'Group created successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while creating group'),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred while creating group'),
    );
  }

  @override
  Future<Result<Group>> updateGroup({
    required int groupId,
    String? name,
    String? description,
    String? groupProfile,
  }) async {
    try {
      final dio = _dio.clone();

      final formData = FormData.fromMap({
        '_method': 'put',
        'name': name,
        'description': description,
        'group_profile': groupProfile != null
            ? await MultipartFile.fromFile(groupProfile)
            : null,
      });

      final response = await dio.post('/group/$groupId', data: formData);

      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'];
        final updatedGroup = Group.fromJson(data);
        return Result.ok(
          data: updatedGroup,
          message: json['message'] ?? 'Group updated successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      print(e);
      return Result.fail(
        ApiError(message: 'An error occurred while updating group'),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred while updating group'),
    );
  }

  @override
  Future<Result<void>> joinGroup(String link) async {
    try {
      final response = await _dio.post(
        '/invite-link',
        data: {'invite_link': link},
      );
      if (response.statusCode == 200) {
        return Result.ok(
          data: null,
          message: response.data['message'] ?? 'Joined group successfully',
        );
      } else if (response.statusCode == 401 ||
          response.statusCode == 422 ||
          response.statusCode == 404 ||
          response.statusCode == 400) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while joining group'),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred while joining group'),
    );
  }

  @override
  Future<Result<void>> leaveGroup(int groupId) async {
    try {
      final response = await _dio.deleteUri(Uri.parse('/user/group/$groupId'));
      if (response.statusCode == 200) {
        return Result.ok(
          data: null,
          message: response.data['message'] ?? 'Left group successfully',
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
  Future<Result<List<User>>> getGroupMembers(
    int groupId,
    int perPage,
    int page,
  ) async {
    try {
      final response = await _dio.get(
        '/group/$groupId/user',
        queryParameters: {'per_page': perPage, 'page': page},
      );

      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final data = json['data'] as List<dynamic>;
        final members = data
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.ok(
          data: members,
          message: json['message'] ?? 'Group members fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while fetching group members'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while fetching group members',
      ),
    );
  }
}
