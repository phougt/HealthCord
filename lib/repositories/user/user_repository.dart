import 'package:family_health_record/models/user/user.dart';
import 'package:family_health_record/utils/result.dart';

abstract class UserRepository {
  Future<Result<User>> getCurrentUser();
}
