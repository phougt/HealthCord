import 'package:family_health_record/repositories/doctor/doctor_repository.dart';
import 'package:flutter/material.dart';

class CreateDoctorViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  Map<String, dynamic> errors = {};
  bool isLoading = false;
  final DoctorRepository _doctorRepository;
  int groupId = 0;

  CreateDoctorViewModel({required DoctorRepository doctorRepository})
    : _doctorRepository = doctorRepository;

  Future<bool> createDoctor() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final doctorName = nameController.text;
    final result = await _doctorRepository.createDoctor(
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
