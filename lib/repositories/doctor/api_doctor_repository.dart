import 'package:dio/dio.dart';
import 'package:family_health_record/models/doctors/doctor.dart';
import 'package:family_health_record/repositories/doctor/doctor_repository.dart';
import 'package:family_health_record/utils/api_error.dart';
import 'package:family_health_record/utils/result.dart';

class ApiDoctorRepository extends DoctorRepository {
  final Dio _dio;
  ApiDoctorRepository({required Dio dio}) : _dio = dio;

  @override
  Future<Result<List<Doctor>>> getDoctorsWithPagination(
    int groupId,
    int perPage,
    int page,
  ) async {
    try {
      final response = await _dio.get(
        '/group/$groupId/doctor',
        queryParameters: {'per_page': perPage, 'page': page},
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'] as List;
        final doctors = data.map((e) => Doctor.fromJson(e)).toList();
        return Result.ok(
          data: doctors,
          message: json['message'] ?? 'Doctors fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while fetching doctors'),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred while fetching doctors'),
    );
  }

  @override
  Future<Result<void>> createDoctor({
    required String name,
    required int groupId,
  }) async {
    try {
      final response = await _dio.post(
        '/group/$groupId/doctor',
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
