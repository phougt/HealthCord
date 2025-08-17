import 'package:family_health_record/repositories/hospital/hospital_repository.dart';
import 'package:flutter/material.dart';

class CreateHospitalViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  Map<String, dynamic> errors = {};
  bool isLoading = false;
  final HospitalRepository _hospitalRepository;
  int groupId = 0;

  CreateHospitalViewModel({required HospitalRepository hospitalRepository})
    : _hospitalRepository = hospitalRepository;

  Future<bool> createHospital() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final doctorName = nameController.text;
    final result = await _hospitalRepository.createHospital(
      name: doctorName,
      groupId: groupId,
    );
    if (result.isSuccessful) {
      isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }
}
