import 'package:family_health_record/managers/auth_token_manager.dart';
import 'package:flutter/material.dart';

class GroupHomeViewModel extends ChangeNotifier {
  final AuthTokenManager _authTokenManager;
  int groupId = 0;
  bool _isLoading = true;
  get isLoading => _isLoading;

  GroupHomeViewModel({required AuthTokenManager authTokenManager})
    : _authTokenManager = authTokenManager;

  Future<bool> loadUserPermissions() async {
    _isLoading = true;
    notifyListeners();

    if (_authTokenManager.permissions.containsKey(groupId.toString())) {
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return _authTokenManager.fetchPermissions(groupId);
  }
}
