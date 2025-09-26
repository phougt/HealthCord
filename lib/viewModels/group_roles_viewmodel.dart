import 'package:family_health_record/managers/permission_manager.dart';
import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/models/roles/role.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter/widgets.dart';

class GroupRolesViewModel extends ChangeNotifier {
  final Group _group;
  final GroupRepository _groupRepository;
  final PermissionManager _permissionManager;
  List<Role> roles = [];
  Map<String, dynamic> errors = {};

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Group get group => _group;

  GroupRolesViewModel({
    required Group group,
    required GroupRepository groupRepository,
    required PermissionManager permissionManager,
  }) : _groupRepository = groupRepository,
       _permissionManager = permissionManager,
       _group = group;

  Future<bool> fetchRoles() async {
    _isLoading = true;
    notifyListeners();
    final result = await _groupRepository.getGroupRoles(group.id);
    if (result.isSuccessful) {
      roles = result.data!;
      _isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error!.toJson();
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> deleteRole(int roleId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _groupRepository.deleteRole(roleId);
    if (result.isSuccessful) {
      roles.removeWhere((role) => role.id == roleId);
      _isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error!.toJson();
    _isLoading = false;
    notifyListeners();
    return false;
  }

  bool hasPermission(String permission) {
    return _permissionManager.hasPermission(permission, group.id);
  }
}
