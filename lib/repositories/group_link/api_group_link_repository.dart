import 'package:dio/dio.dart';
import 'package:family_health_record/models/group_links/group_link.dart';
import 'package:family_health_record/repositories/group_link/group_link_repository.dart';
import 'package:family_health_record/utils/api_error.dart';
import 'package:family_health_record/utils/result.dart';

class ApiGroupLinkRepository extends GroupLinkRepository {
  final Dio _dio;
  ApiGroupLinkRepository({required Dio dio}) : _dio = dio;

  @override
  Future<Result<List<GroupLink>>> getGroupLinks(
    int groupId,
    int pgae,
    int perPage,
  ) async {
    try {
      final response = await _dio.get(
        '/group/$groupId/invite-link',
        queryParameters: {'page': pgae, 'per_page': perPage},
      );
      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final data = json['data'] as List<dynamic>;
        final links = data.map((e) => GroupLink.fromJson(e)).toList();
        return Result.ok(
          data: links,
          message: json['message'] ?? 'Group links fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while fetching group links'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while fetching group links',
      ),
    );
  }

  @override
  Future<Result<GroupLink>> generateNewGroupLink(int groupId) async {
    try {
      final response = await _dio.post('/group/$groupId/invite-link');
      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final link = json['data'] as GroupLink;
        return Result.ok(
          data: link,
          message: json['message'] ?? 'New group link generated successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while generating new group link'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while generating new group link',
      ),
    );
  }

  @override
  Future<Result<void>> revokeGroupLink(int linkId) async {
    try {
      final response = await _dio.delete('/invite-link/$linkId');
      if (response.statusCode == 200) {
        return Result.ok(
          data: null,
          message:
              response.data['message'] ?? 'Group link revoked successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while revoking group link'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while revoking group link',
      ),
    );
  }
}
