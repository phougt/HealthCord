import 'package:family_health_record/models/doctors/doctor.dart';
import 'package:family_health_record/utils/result.dart';

abstract class DoctorRepository {
  Future<Result<List<Doctor>>> getDoctorsWithPagination(
    int groupId,
    int perPage,
    int page,
  );
  Future<Result<void>> createDoctor({
    required String name,
    required int groupId,
  });
}
