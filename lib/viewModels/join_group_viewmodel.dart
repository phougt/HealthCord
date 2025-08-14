import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter/material.dart';

class JoinGroupViewModel extends ChangeNotifier {
  final TextEditingController groupLinkController = TextEditingController();
  Map<String, dynamic> errors = {};
  bool isLoading = false;
  final GroupRepository _groupRepository;

  JoinGroupViewModel({required GroupRepository groupRepository})
    : _groupRepository = groupRepository;

  Future<bool> joinGroup() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final groupLink = groupLinkController.text;

    final result = await _groupRepository.joinGroup(groupLink);

    if (result.isSuccessful) {
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
