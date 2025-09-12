import 'package:family_health_record/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';

import '../enums/role_type.dart';
import '../models/roles/role.dart';

class PermissionManager extends ChangeNotifier {
  final Map<int, Role> _groupRoles = {};
  final UserRepository _userRepository;

  PermissionManager({required UserRepository userRepository})
      : _userRepository = userRepository;

  bool hasRoleType(RoleType roleType, int groupId) {
    final groupRole = _groupRoles[groupId];
    if (groupRole == null) return false;
    return groupRole.type == roleType;
  }

  bool hasPermission(String permission, int groupId) {
    final groupRole = _groupRoles[groupId];
    if (groupRole == null) return false;
    return groupRole.permissions.any((p) => p.slug == permission);
  }

  bool hasPermissionsOfGroup(int groupId) {
    return _groupRoles.containsKey(groupId);
  }

  void setGroupRole(int groupId, Role role) {
    _groupRoles[groupId] = role;
    notifyListeners();
  }

  bool clearGroupPermissionsCache(int groupId) {
    notifyListeners();
    return _groupRoles.remove(groupId) != null;
  }

  void clearAllPermissions() {
    _groupRoles.clear();
    notifyListeners();
  }

  Future<bool> fetchPermissions(int groupId) async {
    final result = await _userRepository.getCurrentUserGroupRole(groupId);

    if (result.isSuccessful) {
      setGroupRole(groupId, result.data!);
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }
}
