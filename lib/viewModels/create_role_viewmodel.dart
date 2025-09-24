import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/repositories/permission/permission_repository.dart';
import 'package:flutter/material.dart';

class CreateRoleViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  Map<String, dynamic> errors = {};
  bool _isLoading = false;
  final PermissionRepository _permissionRepository;
  final Group _group;

  bool get isLoading => _isLoading;

  Group get group => _group;

  CreateRoleViewModel({
    required PermissionRepository permissionRepository,
    required Group group,
  }) : _permissionRepository = permissionRepository,
       _group = group;

  Future<bool> createRole() async {
    errors = {};
    _isLoading = true;
    notifyListeners();

    final roleName = nameController.text;
    final result = await _permissionRepository.createRole(
      name: roleName,
      groupId: group.id,
    );
    if (result.isSuccessful) {
      _isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error?.toJson() ?? {};
    _isLoading = false;
    notifyListeners();
    return false;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
