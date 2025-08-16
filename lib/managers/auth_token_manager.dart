import 'package:dio/dio.dart';
import 'package:family_health_record/models/auth_tokens/auth_token.dart';
import 'package:family_health_record/models/user/user.dart';
import 'package:family_health_record/utils/api_error.dart';
import 'package:family_health_record/utils/result.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenManager extends ChangeNotifier {
  AuthToken? _authToken;
  AuthToken? get authToken => _authToken;
  User? _user;
  User? get user => _user;
  Map<String, List<String>> _permissions = {};
  Map<String, List<String>> get permissions => _permissions;
  bool isFinishedLoading = false;
  final _secureStorage = FlutterSecureStorage();
  final Dio _dio;

  AuthTokenManager({required Dio dio}) : _dio = dio;

  bool hasPermission(String permission, int groupId) {
    final groupPermissions = _permissions[groupId.toString()];
    if (groupPermissions == null) return false;
    return groupPermissions.contains(permission);
  }

  Future<void> loadAuthData() async {
    final accessToken = await _secureStorage.read(key: 'accessToken');
    final accessTokenExpiry = await _secureStorage.read(
      key: 'accessTokenExpiry',
    );

    if (accessToken != null && accessTokenExpiry != null) {
      _authToken = AuthToken(
        accessToken: accessToken,
        accessTokenExpiryDate: DateTime.parse(accessTokenExpiry),
      );

      bool isExpired = _authToken!.accessTokenExpiryDate.isBefore(
        DateTime.now().toUtc(),
      );

      if (isExpired) {
        await clearAuthToken();
        isFinishedLoading = true;
        notifyListeners();
        return;
      }

      _dio.options.headers['Authorization'] =
          'Bearer ${_authToken!.accessToken}';

      await _loadUser();
    }

    isFinishedLoading = true;
    notifyListeners();
  }

  Future<Result<void>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        final json = response.data;
        _authToken = AuthToken.fromJson(json['data']);
        await _secureStorage.write(
          key: 'accessToken',
          value: _authToken!.accessToken,
        );
        await _secureStorage.write(
          key: 'accessTokenExpiry',
          value: _authToken!.accessTokenExpiryDate.toIso8601String(),
        );
        _dio.options.headers['Authorization'] =
            'Bearer ${_authToken!.accessToken}';

        await setAuthToken(_authToken!);
        final userResult = await _loadUser();

        if (!userResult.isSuccessful) {
          return Result.fail(userResult.error!);
        }

        notifyListeners();
        return Result.ok(
          data: null,
          message: json['message'] ?? 'Login successful',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        notifyListeners();
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      notifyListeners();
      return Result.fail(
        ApiError(message: 'An error occurred while logging in'),
      );
    }

    notifyListeners();
    return Result.fail(
      ApiError(message: 'An unexpected error occurred while logging in'),
    );
  }

  Future<Result<void>> logout() async {
    try {
      final response = await _dio.post('/logout');
      if (response.statusCode == 200) {
        await clearAuthToken();
        notifyListeners();
        return Result.ok(
          data: null,
          message: response.data['message'] ?? 'Logout successful',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while logging out'),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred while logging out'),
    );
  }

  Future<void> setAuthToken(AuthToken token) async {
    await _secureStorage.write(key: 'accessToken', value: token.accessToken);
    await _secureStorage.write(
      key: 'accessTokenExpiry',
      value: token.accessTokenExpiryDate.toIso8601String(),
    );
    _authToken = token;
    _dio.options.headers['Authorization'] = 'Bearer ${_authToken!.accessToken}';
    notifyListeners();
  }

  Future<void> clearAuthToken() async {
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'accessTokenExpiry');
    _authToken = null;
    _user = null;
    _dio.options.headers.remove('Authorization');
    notifyListeners();
  }

  Future<Result<void>> _loadUser() async {
    try {
      final response = await _dio.get('/user');
      if (response.statusCode == 200) {
        final json = response.data;
        _user = User.fromJson(json['data']);
        return Result.ok(
          data: null,
          message: json['message'] ?? 'User fetched successfully',
        );
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return Result.fail(ApiError.fromJson(response.data));
      }
    } catch (e) {
      return Result.fail(
        ApiError(message: 'An error occurred while fetching user'),
      );
    }

    return Result.fail(
      ApiError(message: 'An unexpected error occurred while fetching user'),
    );
  }

  Future<bool> fetchPermissions(int groupId) async {
    try {
      final response = await _dio.get('/user/group/$groupId/permission');
      if (response.statusCode == 200) {
        final json = response.data;
        final data = json['data'];
        _permissions['$groupId'] = List<String>.from(data);
        print(_permissions);
        notifyListeners();
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        return false;
      }
    } catch (e) {
      return false;
    }

    return false;
  }
}
