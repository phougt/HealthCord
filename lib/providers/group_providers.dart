import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/providers/dio_provider.dart';
import 'package:family_health_record/repositories/group/api_group_repository.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:family_health_record/controllers/group_controller.dart';

final groupControllerProvider =
    AsyncNotifierProvider<GroupController, List<Group>>(
      () => GroupController(),
    );

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiGroupRepository(dio: dio);
});
