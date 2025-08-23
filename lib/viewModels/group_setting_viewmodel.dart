import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:family_health_record/models/auth_tokens/auth_token.dart';
import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GroupSettingViewModel extends ChangeNotifier {
  int groupId = 0;
  bool isLoading = true;
  Map<String, dynamic> errors = {};
  final AuthTokenManager _authTokenManager;
  final GroupRepository _groupRepository;
  XFile? groupProfile;
  final ImagePicker _imagePicker;
  Group? group;
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupDescriptionController =
      TextEditingController();

  AuthToken? get authToken => _authTokenManager.authToken;

  GroupSettingViewModel({
    required AuthTokenManager authTokenManager,
    required GroupRepository groupRepository,
    required ImagePicker imagePicker,
  }) : _groupRepository = groupRepository,
       _imagePicker = imagePicker,
       _authTokenManager = authTokenManager;

  Future<bool> fetchGroupDetails() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final result = await _groupRepository.getGroupDetails(groupId);

    if (result.isSuccessful) {
      group = result.data;
      groupNameController.text = result.data!.name;
      groupDescriptionController.text = result.data!.description ?? '';
      isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> updateGroupDetails() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final groupName = groupNameController.text;
    final groupDescription = groupDescriptionController.text;

    final result = await _groupRepository.updateGroup(
      groupId: groupId,
      name: groupName,
      description: groupDescription,
      groupProfile: groupProfile?.path,
    );

    if (result.isSuccessful) {
      PaintingBinding.instance.imageCache.evict(
        NetworkImage(result.data!.groupProfile ?? ''),
      );
      isLoading = false;
      notifyListeners();
      return true;
    }

    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> pickGroupProfile() async {
    isLoading = true;
    notifyListeners();

    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
      imageQuality: 50,
      requestFullMetadata: false,
    );

    if (pickedFile != null) {
      groupProfile = pickedFile;
    }

    isLoading = false;
    notifyListeners();
  }

  bool hasPermission(String permission) {
    return _authTokenManager.hasPermission(permission, groupId);
  }

  void undoName() {
    groupNameController.text = group?.name ?? '';
    notifyListeners();
  }

  void undoDescription() {
    groupDescriptionController.text = group?.description ?? '';
    notifyListeners();
  }

  @override
  void dispose() {
    groupNameController.dispose();
    groupDescriptionController.dispose();
    super.dispose();
  }
}
