import './base_error.dart';

class ApiError extends BaseError {
  final String message;
  final Map<String, dynamic>? errors;

  ApiError({required this.message, this.errors});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['message'] ?? 'An error occurred',
      errors: json['errors'] != null
          ? Map<String, dynamic>.from(json['errors'])
          : {},
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'message': message, 'errors': errors};
  }

  @override
  String toString() {
    return 'ApiError(message: $message, errors: $errors)';
  }
}
