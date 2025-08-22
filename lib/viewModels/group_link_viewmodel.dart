import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:family_health_record/models/group_links/group_link.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter/material.dart';

class GroupLinkViewModel extends ChangeNotifier {
  List<GroupLink> groupLinks = [];
  int groupId = 0;
  bool isLoading = true;
  int _page = 0;
  final int perPage = 10;
  Map<String, dynamic> errors = {};
  final GroupRepository _groupRepository;
  final ScrollController scrollController = ScrollController();
  final AuthTokenManager _authTokenManager;

  GroupLinkViewModel({
    required GroupRepository groupRepository,
    required AuthTokenManager authTokenManager,
  }) : _groupRepository = groupRepository,
       _authTokenManager = authTokenManager {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        loadMoreGroupLinks();
      }
    });
  }

  bool hasPermission(String permission) {
    return _authTokenManager.hasPermission(permission, groupId);
  }

  Future<bool> loadMoreGroupLinks() async {
    _page++;
    isLoading = true;
    notifyListeners();

    final result = await _groupRepository.getGroupLinks(
      groupId,
      _page,
      perPage,
    );

    if (result.isSuccessful) {
      groupLinks.addAll(result.data!);
      isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> refreshGroupLinks() async {
    _page = 0;
    groupLinks.clear();
    errors.clear();
    return loadMoreGroupLinks();
  }

  Future<bool> generateNewLink() async {
    isLoading = true;
    notifyListeners();

    final result = await _groupRepository.generateNewGroupLink(groupId);

    if (result.isSuccessful) {
      groupLinks.insert(0, result.data!);
      isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }
}
