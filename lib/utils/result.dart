import 'package:family_health_record/utils/base_error.dart';

class Result<T> {
  final bool isSuccessful;
  final T? data;
  final String? message;
  final BaseError? error;

  Result.ok({this.data, this.message}) : isSuccessful = true, error = null;
  Result.fail(this.error) : isSuccessful = false, data = null, message = null;

  @override
  String toString() {
    return 'Result(data: $data, error: $error)';
  }
}
