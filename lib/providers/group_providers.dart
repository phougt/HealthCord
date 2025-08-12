import 'package:family_health_record/providers/dio_provider.dart';
import 'package:family_health_record/repositories/group/api_group_repository.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:family_health_record/viewModels/group_viewmodel.dart';

final groupViewModelProvider = AsyncNotifierProvider<GroupViewModel, void>(
  () => GroupViewModel(),
);

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiGroupRepository(dio: dio);
});
