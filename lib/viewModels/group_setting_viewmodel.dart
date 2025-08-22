import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:flutter/material.dart';

class GroupSettingViewModel extends ChangeNotifier {
  int groupId = 0;
  bool isLoading = true;
  Map<String, dynamic> errors = {};
  final AuthTokenManager _authTokenManager;

  GroupSettingViewModel({required AuthTokenManager authTokenManager})
    : _authTokenManager = authTokenManager;

  bool hasPermission(String permission) {
    return _authTokenManager.hasPermission(permission, groupId);
  }
}
