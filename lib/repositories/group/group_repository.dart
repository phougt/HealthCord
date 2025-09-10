import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/models/user/user.dart';
import 'package:family_health_record/utils/result.dart';

abstract class GroupRepository {
  Future<Result<List<Group>>> getGroupsWithPagination(int perPage, int page);
  Future<Result<Group>> getGroupDetails(int groupId);
  Future<Result<Group>> updateGroup({
    required int groupId,
    String? name,
    String? description,
    String? groupProfile,
  });
  Future<Result<Group>> createGroup({
    required String name,
    String? description,
    String? groupProfile,
  });
  Future<Result<void>> joinGroup(String link);
  Future<Result<void>> leaveGroup(int groupId);
  Future<Result<void>> archiveGroup(int groupId);
  Future<Result<List<User>>> getGroupMembers(
    int groupId,
    int page,
    int perPage,
  );
}
