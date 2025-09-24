import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/models/permissions/permission.dart';
import 'package:family_health_record/models/roles/role.dart';
import 'package:family_health_record/repositories/permission/permission_repository.dart';
import 'package:flutter/widgets.dart';

class GroupRolePermissionsViewModel extends ChangeNotifier {
  bool _disposed = false;
  final Group _group;
  final Role _role;
  final PermissionRepository _permissionRepository;
  Map<String, List<Permission>> permissions = {};
  Set<int> selectedPermissions = {};
  Map<String, dynamic> errors = {};

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Group get group => _group;

  Role get role => _role;

  GroupRolePermissionsViewModel({
    required Group group,
    required PermissionRepository permissionRepository,
    required Role role,
  }) : _permissionRepository = permissionRepository,
       _group = group,
       _role = role;

  void togglePermission(Permission permission) {
    if (selectedPermissions.contains(permission.id)) {
      selectedPermissions.remove(permission.id);
    } else {
      selectedPermissions.add(permission.id);
    }
    notifyListeners();
  }

  Future<bool> fetchAvailablePermissions() async {
    _isLoading = true;
    notifyListeners();
    final result = await _permissionRepository.getPermissions();
    if (result.isSuccessful) {
      final permissions = result.data!;
      for (var permission in permissions) {
        if (!this.permissions.containsKey(permission.kind)) {
          this.permissions[permission.kind] = <Permission>[];
        }
        this.permissions[permission.kind]!.add(permission);
      }
      _isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error!.toJson();
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> fetchSelectedPermissions() async {
    final result = await _permissionRepository.getRolePermissions(
      roleId: _role.id,
    );
    if (result.isSuccessful) {
      final permissions = result.data!;
      for (var permission in permissions) {
        selectedPermissions.add(permission.id);
      }
      return true;
    }

    return false;
  }

  Future<void> setDefaultSelectedPermissions() async {
    _isLoading = true;
    notifyListeners();
    permissions.clear();

    final result = await _permissionRepository.getRolePermissions(
      roleId: _role.id,
    );

    if (result.isSuccessful) {
      await fetchAvailablePermissions();
      selectedPermissions.clear();
      for (var permission in result.data!) {
        selectedPermissions.add(permission.id);
      }
    }

    notifyListeners();
    _isLoading = false;
  }

  Future<bool> saveChanges() async {
    _isLoading = true;
    notifyListeners();

    final result = await _permissionRepository.updateRolePermissions(
      roleId: _role.id,
      permissionIds: selectedPermissions,
    );
    if (result.isSuccessful) {
      await fetchSelectedPermissions();
      _isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error!.toJson();
    _isLoading = false;
    notifyListeners();
    return false;
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }
}
