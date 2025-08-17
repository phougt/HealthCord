import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:family_health_record/models/doctors/doctor.dart';
import 'package:family_health_record/models/hospitals/hospital.dart';
import 'package:family_health_record/repositories/doctor/doctor_repository.dart';
import 'package:family_health_record/repositories/hospital/hospital_repository.dart';
import 'package:flutter/material.dart';

class MedicalEntitiesViewModel extends ChangeNotifier {
  List<Hospital> hospitals = [];
  List<Doctor> doctors = [];
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  Map<String, dynamic> doctorErrors = {};
  Map<String, dynamic> hospitalErrors = {};
  int _page = 1;
  final int _perPage =
      100; // Haven't implemented infinite scroll yet, so using a fixed perPage value
  int groupId = 0;
  final DoctorRepository _doctorRepository;
  final HospitalRepository _hospitalRepository;
  final AuthTokenManager _authTokenManager;

  MedicalEntitiesViewModel({
    required DoctorRepository doctorRepository,
    required HospitalRepository hospitalRepository,
    required AuthTokenManager authTokenManager,
  }) : _doctorRepository = doctorRepository,
       _hospitalRepository = hospitalRepository,
       _authTokenManager = authTokenManager;

  Future<bool> loadMoreEntities() async {
    _page++;
    _isLoading = true;
    notifyListeners();

    final doctorResult = await _doctorRepository.getDoctorsWithPagination(
      groupId,
      _perPage,
      _page,
    );
    final hospitalResult = await _hospitalRepository.getHospitalsWithPagination(
      groupId,
      _perPage,
      _page,
    );

    if (doctorResult.isSuccessful) {
      doctors.addAll(doctorResult.data as List<Doctor>);
    }

    if (hospitalResult.isSuccessful) {
      hospitals.addAll(hospitalResult.data as List<Hospital>);
    }

    if (!doctorResult.isSuccessful && !hospitalResult.isSuccessful) {
      doctorErrors = doctorResult.error?.toJson() ?? {};
      hospitalErrors = hospitalResult.error?.toJson() ?? {};
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> refreshEntities() async {
    _page = 0;
    doctors.clear();
    hospitals.clear();
    doctorErrors.clear();
    hospitalErrors.clear();
    return loadMoreEntities();
  }

  bool hasPermissions(String permission) {
    return _authTokenManager.hasPermission(permission, groupId);
  }
}
