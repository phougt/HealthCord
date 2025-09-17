import 'package:family_health_record/managers/permission_manager.dart';
import 'package:family_health_record/models/doctors/doctor.dart';
import 'package:family_health_record/models/groups/group.dart';
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
  final int _perPage = 10;
  final Group _group;

  Group get group => _group;
  final DoctorRepository _doctorRepository;
  final HospitalRepository _hospitalRepository;
  final PermissionManager _permissionManager;
  final ScrollController scrollController = ScrollController();

  MedicalEntitiesViewModel({
    required DoctorRepository doctorRepository,
    required HospitalRepository hospitalRepository,
    required PermissionManager permissionManager,
    required Group group,
  }) : _doctorRepository = doctorRepository,
       _hospitalRepository = hospitalRepository,
       _permissionManager = permissionManager,
       _group = group {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        loadMoreEntities();
      }
    });
  }

  Future<bool> loadMoreEntities() async {
    _page++;
    _isLoading = true;
    notifyListeners();

    final doctorResult = await _doctorRepository.getDoctorsWithPagination(
      group.id,
      _perPage,
      _page,
    );
    final hospitalResult = await _hospitalRepository.getHospitalsWithPagination(
      group.id,
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
    return _permissionManager.hasPermission(permission, group.id);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
