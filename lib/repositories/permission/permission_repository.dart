import 'package:family_health_record/models/permissions/permission.dart';
import 'package:family_health_record/utils/result.dart';

abstract class PermissionRepository {
  Future<Result<List<Permission>>> getPermissions();

  Future<Result<void>> updateRolePermissions({
    required int roleId,
    required Iterable<int> permissionIds,
  });

  Future<Result<List<Permission>>> getRolePermissions({required int roleId});

  Future<Result<void>> createRole({required String name, required int groupId});
}
