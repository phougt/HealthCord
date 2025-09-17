import 'package:family_health_record/managers/permission_manager.dart';
import 'package:family_health_record/models/groups/group.dart';
import 'package:flutter/material.dart';

class GroupHomeViewModel extends ChangeNotifier {
  final PermissionManager _permissionManager;
  final Group _group;

  Group get group => _group;
  bool _isLoading = true;

  get isLoading => _isLoading;

  GroupHomeViewModel({
    required PermissionManager permissionManager,
    required Group group,
  }) : _permissionManager = permissionManager,
       _group = group;

  Future<bool> loadUserPermissions() async {
    _isLoading = true;
    notifyListeners();

    if (_permissionManager.hasPermissionsOfGroup(group.id)) {
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return _permissionManager.fetchPermissions(group.id);
  }
}
