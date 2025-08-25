import 'package:family_health_record/managers/permission_manager.dart';
import 'package:flutter/material.dart';

class GroupHomeViewModel extends ChangeNotifier {
  final PermissionManager _permissionManager;
  int groupId = 0;
  bool _isLoading = true;
  get isLoading => _isLoading;

  GroupHomeViewModel({required PermissionManager permissionManager})
    : _permissionManager = permissionManager;

  Future<bool> loadUserPermissions() async {
    _isLoading = true;
    notifyListeners();

    if (_permissionManager.hasPermissionsOfGroup(groupId)) {
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return _permissionManager.fetchPermissions(groupId);
  }
}
