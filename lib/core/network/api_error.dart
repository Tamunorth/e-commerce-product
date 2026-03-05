import 'package:dio/dio.dart';

class ApiError implements Exception {
  const ApiError(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  factory ApiError.fromDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        const ApiError('Connection timed out. Please try again.'),
      DioExceptionType.connectionError =>
        const ApiError('No internet connection.'),
      DioExceptionType.badResponse => ApiError(
          _messageFromStatus(e.response?.statusCode),
          statusCode: e.response?.statusCode,
        ),
      _ => ApiError(e.message ?? 'Something went wrong.'),
    };
  }

  static String _messageFromStatus(int? status) => switch (status) {
    400 => 'Bad request.',
    404 => 'Not found.',
    500 => 'Server error. Please try again later.',
    _ => 'Something went wrong.',
  };

  @override
  String toString() => 'ApiError: $message (status: $statusCode)';
}
