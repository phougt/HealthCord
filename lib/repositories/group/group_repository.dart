import 'package:family_health_record/models/group_links/group_link.dart';
import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/models/user/user.dart';
import 'package:family_health_record/utils/result.dart';

abstract class GroupRepository {
  Future<Result<List<Group>>> getGroupsWithPagination(int perPage, int page);
  Future<Result<Group>> createGroup({
    required String name,
    String? description,
    String? groupProfile,
  });
  Future<Result<void>> joinGroup(String link);
  Future<Result<void>> leaveGroup(int groupId);
  Future<Result<List<User>>> getGroupMembers(
    int groupId,
    int page,
    int perPage,
  );
  Future<Result<List<GroupLink>>> getGroupLinks(
    int groupId,
    int page,
    int perPage,
  );
  Future<Result<GroupLink>> generateNewGroupLink(int groupId);
}
