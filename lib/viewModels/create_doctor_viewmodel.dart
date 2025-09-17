import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/repositories/doctor/doctor_repository.dart';
import 'package:flutter/material.dart';

class CreateDoctorViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  Map<String, dynamic> errors = {};
  bool isLoading = false;
  final DoctorRepository _doctorRepository;
  final Group _group;

  Group get group => _group;

  CreateDoctorViewModel({
    required DoctorRepository doctorRepository,
    required Group group,
  }) : _doctorRepository = doctorRepository,
       _group = group;

  Future<bool> createDoctor() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final doctorName = nameController.text;
    final result = await _doctorRepository.createDoctor(
      name: doctorName,
      groupId: group.id,
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

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
