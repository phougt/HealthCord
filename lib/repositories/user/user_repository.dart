import 'package:family_health_record/models/roles/role.dart';
import 'package:family_health_record/models/user/user.dart';
import 'package:family_health_record/utils/result.dart';

abstract class UserRepository {
  Future<Result<User>> getCurrentUser();
  Future<Result<void>> leaveGroup(int groupId);
  Future<Result<Role>> getCurrentUserRole(int groupId);
  Future<Result<List<String>>> getCurrentUserGroupPermissions(int groupId);
}
