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
}
