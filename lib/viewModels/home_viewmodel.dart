import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  static const colorPool = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.amber,
    Colors.cyan,
    Colors.lime,
    Colors.indigo,
    Colors.pink,
  ];
  static const iconPool = [
    Icons.adb_outlined,
    Icons.account_balance_wallet_rounded,
    Icons.accessibility_new_rounded,
    Icons.handshake_rounded,
    Icons.group_work,
    Icons.nature,
  ];
  final GroupRepository _groupRepository;
  final scrollController = ScrollController();
  final groups = <Group>[];
  final perPage = 10;
  bool hasMore = true;
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

  Future<bool> leaveGroup(int groupId) async {
    isLoading = true;
    notifyListeners();

    final result = await _groupRepository.leaveGroup(groupId);
    if (result.isSuccessful) {
      groups.removeWhere((group) => group.id == groupId);
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
