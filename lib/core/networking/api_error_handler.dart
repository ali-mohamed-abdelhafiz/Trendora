import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/auth/model/error_model.dart';

class ApiErrorHandler {
  static ErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ErrorModel(
            statusCode: 0,
            message: "Connection timeout",
            errors: {},
          );

        case DioExceptionType.receiveTimeout:
          return ErrorModel(
            statusCode: 0,
            message: "Receive timeout",
            errors: {},
          );

        case DioExceptionType.connectionError:
          return ErrorModel(
            statusCode: 0,
            message: "No internet connection",
            errors: {},
          );

        case DioExceptionType.badResponse:
          return _handleStatusCode(
              error.response?.statusCode, error.response?.data);

        default:
          return ErrorModel(
            statusCode: 0,
            message: "Unexpected error occurred",
            errors: {},
          );
      }
    }
    return ErrorModel(
      statusCode: 0,
      message: "Something went wrong",
      errors: {},
    );
  }

  static ErrorModel _handleStatusCode(int? statusCode, dynamic data) {
    if (data != null && data is Map<String, dynamic>) {
      return ErrorModel.fromJson(data);
    }

    switch (statusCode) {
      case 400:
        return ErrorModel(statusCode: 400, message: "Bad request", errors: {});
      case 401:
        return ErrorModel(statusCode: 401, message: "Unauthorized", errors: {});
      case 404:
        return ErrorModel(statusCode: 404, message: "Not found", errors: {});
      case 500:
        return ErrorModel(statusCode: 500, message: "Server error", errors: {});
      default:
        return ErrorModel(
            statusCode: statusCode ?? 0, message: "Server error", errors: {});
    }
  }
}

class ApiErrorHandler2 {
  static String handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timeout";

        case DioExceptionType.receiveTimeout:
          return "Receive timeout";

        case DioExceptionType.connectionError:
          return "No internet connection";

        case DioExceptionType.badResponse:
          return _handleStatusCode(error.response?.statusCode);

        default:
          return "Unexpected error occurred";
      }
    }
    return "Something went wrong";
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad request";

      case 401:
        return "Unauthorized";

      case 404:
        return "Not found";

      case 500:
        return "Server error";

      default:
        return "Server error";
    }
  }
}
