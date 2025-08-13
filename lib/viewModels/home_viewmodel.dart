import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final GroupRepository _groupRepository;
  final scrollController = ScrollController();
  final groups = <Group>[];
  final perPage = 10;
  int currentPage = 1;
  bool isLoading = false;
  Map<String, dynamic> errors = {};

  HomeViewModel({required GroupRepository groupRepository})
    : _groupRepository = groupRepository {
    refreshGroups();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        loadMoreGroups();
      }
    });
    notifyListeners();
  }

  Future<bool> loadMoreGroups() async {
    if (isLoading) return false;
    isLoading = true;
    notifyListeners();
    currentPage++;

    final result = await _groupRepository.getGroupsWithPagination(
      perPage,
      currentPage,
    );
    if (result.isSuccessful) {
      groups.addAll(result.data!);
      isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> refreshGroups() async {
    currentPage = 0;
    groups.clear();
    notifyListeners();
    return loadMoreGroups();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
