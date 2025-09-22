import 'package:family_health_record/managers/permission_manager.dart';
import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/models/user/user.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter/material.dart';

class GroupMemberViewModel extends ChangeNotifier {
  bool _disposed = false;
  final PermissionManager _permissionManager;
  final GroupRepository _groupRepository;
  final ScrollController scrollController = ScrollController();
  final Group _group;

  Group get group => _group;
  List<User> members = [];
  bool isLoading = true;
  Map<String, dynamic> errors = {};
  int page = 1;
  int perPage = 10;

  GroupMemberViewModel({
    required GroupRepository groupRepository,
    required PermissionManager permissionManager,
    required Group group,
  }) : _groupRepository = groupRepository,
       _permissionManager = permissionManager,
       _group = group {
    refreshGroupMembers();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        loadMoreGroupMembers();
      }
    });
  }

  Future<bool> loadMoreGroupMembers() async {
    page++;
    isLoading = true;
    notifyListeners();
    final result = await _groupRepository.getGroupMembers(
      group.id,
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
    return _permissionManager.hasPermission(permission, group.id);
  }

  @override
  void dispose() {
    scrollController.dispose();
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }
}
