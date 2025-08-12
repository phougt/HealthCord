import 'package:family_health_record/controllers/auth_controller.dart';
import 'package:family_health_record/repositories/auth/api_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/auth/auth_repository.dart';
import '../models/auth_tokens/auth_token.dart';
import '../providers/dio_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authControllerProvider =
    AutoDisposeAsyncNotifierProvider<AuthController, void>(
      () => AuthController(),
    );

final authTokenProvider = AsyncNotifierProvider<AuthTokenNotifier, AuthToken?>(
  () => AuthTokenNotifier(),
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiAuthRepository(dio: dio);
});

class AuthTokenNotifier extends AsyncNotifier<AuthToken?> {
  final secureStorage = FlutterSecureStorage();

  @override
  Future<AuthToken?> build() async {
    if (!await secureStorage.containsKey(key: 'accessToken')) {
      return null;
    }

    final acccessToken = await secureStorage.read(key: 'accessToken');
    final refreshToken = await secureStorage.read(key: 'refreshToken');
    final accessTokenExpiryDate = await secureStorage.read(
      key: 'accessTokenExpiryDate',
    );
    final refreshTokenExpiryDate = await secureStorage.read(
      key: 'refreshTokenExpiryDate',
    );

    final isValidAuthToken =
        acccessToken != null &&
        refreshToken != null &&
        accessTokenExpiryDate != null &&
        refreshTokenExpiryDate != null;

    if (!isValidAuthToken) {
      secureStorage.delete(key: 'accessToken');
      secureStorage.delete(key: 'refreshToken');
      secureStorage.delete(key: 'accessTokenExpiryDate');
      secureStorage.delete(key: 'refreshTokenExpiryDate');
      return null;
    }

    final authToken = AuthToken(
      accessToken: acccessToken,
      accessTokenExpiryDate: DateTime.parse(accessTokenExpiryDate),
      refreshToken: refreshToken,
      refreshTokenExpiryDate: DateTime.parse(refreshTokenExpiryDate),
    );

    final isExpired = DateTime.now().isAfter(
      authToken.accessTokenExpiryDate.toLocal(),
    );

    if (isExpired) {
      final authRepository = ref.read(authRepositoryProvider);
      final result = await authRepository.getFreshToken(authToken.refreshToken);
      if (result.isSuccessful) {
        await secureStorage.write(
          key: 'accessToken',
          value: result.data!.accessToken,
        );
        await secureStorage.write(
          key: 'accessTokenExpiryDate',
          value: result.data!.accessTokenExpiryDate.toIso8601String(),
        );
        await secureStorage.write(
          key: 'refreshToken',
          value: result.data!.refreshToken,
        );
        await secureStorage.write(
          key: 'refreshTokenExpiryDate',
          value: result.data!.refreshTokenExpiryDate.toIso8601String(),
        );
        return result.data;
      } else {
        await secureStorage.delete(key: 'accessToken');
        await secureStorage.delete(key: 'refreshToken');
        await secureStorage.delete(key: 'accessTokenExpiryDate');
        await secureStorage.delete(key: 'refreshTokenExpiryDate');
        return null;
      }
    }

    return authToken;
  }

  Future<void> setAuthToken(AuthToken token) async {
    await secureStorage.write(key: 'accessToken', value: token.accessToken);
    await secureStorage.write(
      key: 'accessTokenExpiryDate',
      value: token.accessTokenExpiryDate.toIso8601String(),
    );
    await secureStorage.write(key: 'refreshToken', value: token.refreshToken);
    await secureStorage.write(
      key: 'refreshTokenExpiryDate',
      value: token.refreshTokenExpiryDate.toIso8601String(),
    );
    state = AsyncValue.data(token);
  }

  Future<void> clearAuthToken() async {
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'refreshToken');
    await secureStorage.delete(key: 'accessTokenExpiryDate');
    await secureStorage.delete(key: 'refreshTokenExpiryDate');
    state = AsyncValue.data(null);
  }
}
