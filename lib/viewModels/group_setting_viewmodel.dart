import 'package:family_health_record/managers/permission_manager.dart';
import 'package:family_health_record/managers/session_manager.dart';
import 'package:family_health_record/models/auth_tokens/auth_token.dart';
import 'package:family_health_record/models/groups/group.dart';
import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:family_health_record/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../enums/role_type.dart';

class GroupSettingViewModel extends ChangeNotifier {
  bool _disposed = false;
  bool isLoading = true;
  Map<String, dynamic> errors = {};
  final SessionManager _authTokenManager;
  final PermissionManager _permissionManager;
  final GroupRepository _groupRepository;
  final UserRepository _userRepository;
  XFile? groupProfile;
  final ImagePicker _imagePicker;
  Group group;
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupDescriptionController =
      TextEditingController();

  AuthToken? get authToken => _authTokenManager.authToken;

  bool get isChanged {
    return (groupNameController.text != group.name ||
        groupDescriptionController.text != (group.description ?? '') ||
        groupProfile != null);
  }

  GroupSettingViewModel({
    required SessionManager authTokenManager,
    required UserRepository userRepository,
    required PermissionManager permissionManager,
    required GroupRepository groupRepository,
    required ImagePicker imagePicker,
    required this.group,
  }) : _groupRepository = groupRepository,
       _userRepository = userRepository,
       _imagePicker = imagePicker,
       _permissionManager = permissionManager,
       _authTokenManager = authTokenManager;

  Future<bool> fetchGroupDetails() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final result = await _groupRepository.getGroupDetails(group.id);

    if (result.isSuccessful) {
      group = result.data!;
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
      groupId: group.id,
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

  Future<bool> leaveGroup() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final result = await _userRepository.leaveGroup(group.id);

    if (result.isSuccessful) {
      isLoading = false;
      _permissionManager.clearGroupPermissionsCache(group.id);
      notifyListeners();
      return true;
    }

    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> archiveGroup() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final result = await _groupRepository.archiveGroup(group.id);

    if (result.isSuccessful) {
      isLoading = false;
      _permissionManager.clearGroupPermissionsCache(group.id);
      notifyListeners();
      return true;
    }

    errors = result.error?.toJson() ?? {};
    isLoading = false;
    notifyListeners();
    return false;
  }

  bool hasPermission(String permission) {
    return _permissionManager.hasPermission(permission, group.id);
  }

  bool hasRoleType(RoleType roleType) {
    return _permissionManager.hasRoleType(roleType, group.id);
  }

  void undoName() {
    groupNameController.text = group.name;
    notifyListeners();
  }

  void undoDescription() {
    groupDescriptionController.text = group.description ?? '';
    notifyListeners();
  }

  @override
  void dispose() {
    groupNameController.dispose();
    groupDescriptionController.dispose();
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }
}
