import '../../models/auth_tokens/auth_token.dart';
import '../../utils/result.dart';

abstract class AuthRepository {
  Future<Result<AuthToken>> getFreshToken(String refreshToken);
  Future<Result<AuthToken>> login(String username, String password);
  Future<Result<AuthToken>> signup({
    required String username,
    required String password,
    required String confirmPassword,
    required String email,
    required String firstName,
    required String lastName,
  });
  Future<Result<void>> logout();
}
