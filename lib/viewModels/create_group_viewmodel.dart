import 'package:family_health_record/repositories/group/group_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupViewModel extends ChangeNotifier {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupDescriptionController =
      TextEditingController();
  XFile? groupProfile;
  Map<String, dynamic> errors = {};
  bool isLoading = false;
  final GroupRepository _groupRepository;
  final ImagePicker _imagePicker;

  CreateGroupViewModel({
    required GroupRepository groupRepository,
    required ImagePicker imagePicker,
  }) : _imagePicker = imagePicker,
       _groupRepository = groupRepository;

  Future<void> pickGroupProfile() async {
    isLoading = true;
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

  Future<bool> createGroup() async {
    errors = {};
    isLoading = true;
    notifyListeners();

    final groupName = groupNameController.text;
    final groupDescription = groupDescriptionController.text;

    final result = await _groupRepository.createGroup(
      name: groupName,
      description: groupDescription.isNotEmpty ? groupDescription : null,
      groupProfile: groupProfile?.path,
    );

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

  @override
  void dispose() {
    groupNameController.dispose();
    groupDescriptionController.dispose();
    super.dispose();
  }
}
