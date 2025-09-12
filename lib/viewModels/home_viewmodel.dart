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
  bool isArchived = false;
  final unarchivedGroups = <Group>[];
  final archivedGroups = <Group>[];
  final perPage = 10;
  bool hasMore = true;
  int archivedCurrentPage = 1;
  int unarchivedCurrentPage = 1;
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
    final int currentPage;
    if (isArchived) {
      currentPage = ++archivedCurrentPage;
    } else {
      currentPage = ++unarchivedCurrentPage;
    }

    final result = await _groupRepository.getGroupsWithPagination(
      perPage: perPage,
      page: currentPage,
      isArchived: isArchived,
    );
    if (result.isSuccessful) {
      if (isArchived) {
        archivedGroups.addAll(result.data!);
      } else {
        unarchivedGroups.addAll(result.data!);
      }

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
    if (isArchived) {
      archivedCurrentPage = 0;
      archivedGroups.clear();
    } else {
      unarchivedCurrentPage = 0;
      unarchivedGroups.clear();
    }
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
      unarchivedGroups.removeWhere((group) => group.id == groupId);
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
