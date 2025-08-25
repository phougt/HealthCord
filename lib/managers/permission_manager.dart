import 'package:family_health_record/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';

class PermissionManager extends ChangeNotifier {
  final Map<int, List<String>> _groupPermissions = {};
  final UserRepository _userRepository;

  PermissionManager({required UserRepository userRepository})
    : _userRepository = userRepository;

  bool hasPermission(String permission, int groupId) {
    final groupPermissions = _groupPermissions[groupId];
    if (groupPermissions == null) return false;
    return groupPermissions.contains(permission);
  }

  bool hasPermissionsOfGroup(int groupId) {
    return _groupPermissions.containsKey(groupId);
  }

  void setGroupPermissions(int groupId, List<String> permissions) {
    _groupPermissions[groupId] = permissions;
    notifyListeners();
  }

  bool clearGroupPermissionsCache(int groupId) {
    notifyListeners();
    return _groupPermissions.remove(groupId) != null;
  }

  void clearAllPermissions() {
    _groupPermissions.clear();
    notifyListeners();
  }

  Future<bool> fetchPermissions(int groupId) async {
    final result = await _userRepository.getCurrentUserGroupPermissions(
      groupId,
    );

    if (result.isSuccessful) {
      setGroupPermissions(groupId, result.data!);
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }
}
