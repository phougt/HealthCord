import 'package:family_health_record/models/group_links/group_link.dart';
import 'package:family_health_record/utils/result.dart';

abstract class GroupLinkRepository {
  Future<Result<List<GroupLink>>> getGroupLinks(
    int groupId,
    int page,
    int perPage,
  );
  Future<Result<GroupLink>> generateNewGroupLink(int groupId);
  Future<Result<void>> revokeGroupLink(int linkId);
}
