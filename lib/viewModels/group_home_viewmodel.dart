import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:flutter/material.dart';

class GroupHomeViewModel extends ChangeNotifier {
  final AuthTokenManager _authTokenManager;
  bool _isLoading = true;
  get isLoading => _isLoading;

  GroupHomeViewModel({required AuthTokenManager authTokenManager})
    : _authTokenManager = authTokenManager;

  Future<bool> loadUserPermissions(int groupId) async {
    if (_authTokenManager.permissions.containsKey(groupId.toString())) {
      return true;
    }

    return _authTokenManager.fetchPermissions(groupId);
  }
}
