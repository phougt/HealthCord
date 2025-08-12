import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/providers/group_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class GroupController extends AsyncNotifier<List<Group>> {
  final scrollController = ScrollController();
  final perPage = 10;
  int currentPage = 1;

  @override
  Future<List<Group>> build() async {
    ref.onDispose(() {
      scrollController.dispose();
    });

    final repo = ref.read(groupRepositoryProvider);
    final result = await repo.getGroupsWithPagination(perPage, currentPage);
    if (result.isSuccessful) {
      return result.data!;
    } else {
      return [];
    }
  }

  Future<bool> loadMoreGroups() async {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      state = const AsyncValue.loading();
      currentPage++;
      final repo = ref.read(groupRepositoryProvider);
      final result = await repo.getGroupsWithPagination(perPage, currentPage);
      if (result.isSuccessful) {
        state = AsyncData([...state.value ?? [], ...result.data!]);
        return true;
      } else {
        state = AsyncError(result.error!.toJson(), StackTrace.current);
      }
    }

    return false;
  }

  Future<bool> refreshGroups() async {
    state = const AsyncValue.loading();
    currentPage = 1;
    final repo = ref.read(groupRepositoryProvider);
    final result = await repo.getGroupsWithPagination(perPage, currentPage);
    if (result.isSuccessful) {
      state = AsyncData(result.data!);
      return true;
    } else {
      state = AsyncError(result.error!.toJson(), StackTrace.current);
    }

    return false;
  }
}
