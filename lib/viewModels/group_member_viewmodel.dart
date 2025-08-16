import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:family_health_record/models/user/user.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter/foundation.dart';

class GroupMemberViewModel extends ChangeNotifier {
  final AuthTokenManager _authTokenManager;
  final GroupRepository _groupRepository;
  int groupId = 0;
  List<User> members = [];
  bool isLoading = true;
  Map<String, dynamic> errors = {};
  int page = 1;
  int perPage = 10;

  GroupMemberViewModel({
    required GroupRepository groupRepository,
    required AuthTokenManager authTokenManager,
  }) : _groupRepository = groupRepository,
       _authTokenManager = authTokenManager;

  Future<bool> loadMoreGroupMembers() async {
    page++;
    isLoading = true;
    notifyListeners();
    final result = await _groupRepository.getGroupMembers(
      groupId,
      perPage,
      page,
    );

    if (result.isSuccessful) {
      members.addAll(result.data as List<User>);
      isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> refreshGroupMembers() async {
    page = 0;
    members.clear();
    errors.clear();
    return loadMoreGroupMembers();
  }

  bool hasPermission(String permission) {
    return _authTokenManager.hasPermission(permission, groupId);
  }
}
