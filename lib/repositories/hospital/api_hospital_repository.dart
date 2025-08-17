import 'package:dio/dio.dart';
import 'package:family_health_record/models/hospitals/hospital.dart';
import 'package:family_health_record/repositories/hospital/hospital_repository.dart';
import 'package:family_health_record/utils/api_error.dart';
import 'package:family_health_record/utils/result.dart';

class ApiHospitalRepository extends HospitalRepository {
  final Dio _dio;
  ApiHospitalRepository({required Dio dio}) : _dio = dio;

  @override
  Future<Result<List<Hospital>>> getHospitalsWithPagination(
    int groupId,
    int perPage,
    int page,
  ) async {
    try {
      final response = await _dio.get(
        '/group/$groupId/hospital',
        queryParameters: {'perPage': perPage, 'page': page},
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'] as List;
        final hospitals = data.map((e) => Hospital.fromJson(e)).toList();
        return Result.ok(
          data: hospitals,
          message: 'Hospitals fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while fetching hospitals'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while fetching hospitals',
      ),
    );
  }

  @override
  Future<Result<void>> createHospital({
    required String name,
    required int groupId,
  }) async {
    try {
      final response = await _dio.post(
        '/group/$groupId/hospital',
        data: {'name': name},
      );
      if (response.statusCode == 200) {
        final json = response.data;
        return Result.ok(
          data: null,
          message: json['message'] ?? 'Doctor created successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while creating the doctor'),
      );
    }

    return Result.fail(
      ApiError(
        message: 'An unexpected error occurred while creating the doctor',
      ),
    );
  }
}
