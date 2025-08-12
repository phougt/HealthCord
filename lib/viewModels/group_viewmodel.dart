import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/providers/group_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class GroupViewModel extends AsyncNotifier<void> {
  final scrollController = ScrollController();
  final groups = <Group>[];
  final perPage = 10;
  int currentPage = 1;

  @override
  Future<void> build() async {
    ref.onDispose(() {
      scrollController.dispose();
    });

    final repo = ref.read(groupRepositoryProvider);
    final result = await repo.getGroupsWithPagination(perPage, currentPage);
    if (result.isSuccessful) {
      groups.addAll(result.data!);
      state = AsyncData(null);
    } else {
      state = AsyncError(result.error!.toJson(), StackTrace.current);
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
        groups.addAll(result.data!);
        state = AsyncData(null);
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
      groups.clear();
      groups.addAll(result.data!);
      state = AsyncData(null);
      return true;
    } else {
      state = AsyncError(result.error!.toJson(), StackTrace.current);
    }

    return false;
  }
}
