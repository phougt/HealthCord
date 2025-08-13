import 'package:family_health_record/viewModels/auth_viewmodel.dart';
import 'package:family_health_record/repositories/auth/api_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/auth/auth_repository.dart';
import '../models/auth_tokens/auth_token.dart';
import '../providers/dio_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final authViewModelProvider =
    AutoDisposeAsyncNotifierProvider<AuthViewModel, void>(
      () => AuthViewModel(),
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
    final accessTokenExpiryDate = await secureStorage.read(
      key: 'accessTokenExpiryDate',
    );

    final isValidAuthToken =
        acccessToken != null && accessTokenExpiryDate != null;

    if (!isValidAuthToken) {
      secureStorage.delete(key: 'accessToken');
      secureStorage.delete(key: 'accessTokenExpiryDate');
      return null;
    }

    final authToken = AuthToken(
      accessToken: acccessToken,
      accessTokenExpiryDate: DateTime.parse(accessTokenExpiryDate),
    );

    final isExpired = DateTime.now().isAfter(
      authToken.accessTokenExpiryDate.toLocal(),
    );

    if (isExpired) {
      await secureStorage.delete(key: 'accessToken');
      await secureStorage.delete(key: 'accessTokenExpiryDate');
      return null;
    }

    return authToken;
  }

  Future<void> setAuthToken(AuthToken token) async {
    await secureStorage.write(key: 'accessToken', value: token.accessToken);
    await secureStorage.write(
      key: 'accessTokenExpiryDate',
      value: token.accessTokenExpiryDate.toIso8601String(),
    );
    state = AsyncValue.data(token);
  }

  Future<void> clearAuthToken() async {
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'accessTokenExpiryDate');
    state = AsyncValue.data(null);
  }
}
