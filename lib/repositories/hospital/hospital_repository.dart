import 'package:family_health_record/models/hospitals/hospital.dart';
import 'package:family_health_record/utils/result.dart';

abstract class HospitalRepository {
  Future<Result<List<Hospital>>> getHospitalsWithPagination(
    int groupId,
    int perPage,
    int page,
  );
  Future<Result<void>> createHospital({
    required String name,
    required int groupId,
  });
}
