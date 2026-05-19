import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../data/resources/caches/shared_preferences.dart';
import 'api_end_points.dart';
import 'error_handle.dart';
import 'response_handle.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
  static Map<String, String>? headers;

  static Future<void> headerSet() async {
    final token = await SharedPreferenceData.getToken();
    // log(token ?? '');
    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  /// GET request
  Future<dynamic> getRequest({
    required String endpoints,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      log("\n\n\n\nurl :${ApiEndpoints.baseUrl}/$endpoints \n\n\n\n");
      log(headers.toString());
      final response = await _dio.get(
        '/$endpoints',
        queryParameters: queryParameters,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      // log("\n\n\nGET Request Successful: ${response.data}\n\n\n");
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        // Return the user-friendly error string
        return {"success": false, "message": ErrorHandle.handleDioError(e)};
      } else {
        return {
          "success": false,
          "message": "An unexpected error occurred: $e",
        };
      }
    }
  }

  Future<dynamic> postRequest({
    required String endpoints,
    Map<String, dynamic>? body,
    FormData? formData,
  }) async {
    try {
      log("\n\n\n\nurl :${ApiEndpoints.baseUrl}/$endpoints \n\n\n\n");
      final response = await _dio.post(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        // Return the user-friendly error string
        return {"success": false, "message": ErrorHandle.handleDioError(e)};
      } else {
        return {
          "success": false,
          "message": "An unexpected error occurred: $e",
        };
      }
    }
  }

  /// PUT request
  Future<dynamic> putRequest({
    required String endpoints,
    Map<String, dynamic>? body,
    FormData? formData,
  }) async {
    try {
      log("\n\n\n\nurl :${ApiEndpoints.baseUrl}/$endpoints \n\n\n\n");
      final response = await _dio.put(
        '/$endpoints',
        data: body,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      // debugPrint("\nPUT Request Successful: ${response.data}\n");
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        // Return the user-friendly error string
        return {"success": false, "message": ErrorHandle.handleDioError(e)};
      } else {
        return {
          "success": false,
          "message": "An unexpected error occurred: $e",
        };
      }
    }
  }

  /// PATCH request
  Future<dynamic> patchRequest({
    required String endpoints,
    Map<String, dynamic>? body,

    FormData? formData,
  }) async {
    try {
      log("\n\n\n\nurl :${ApiEndpoints.baseUrl}/$endpoints \n\n\n\n");
      final response = await _dio.patch(
        '${ApiEndpoints.baseUrl}/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers ?? {"Content-Type": "multipart/form-data"},
        ),
      );

      debugPrint("\nPATCH Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        // Return the user-friendly error string
        return {"success": false, "message": ErrorHandle.handleDioError(e)};
      } else {
        return {
          "success": false,
          "message": "An unexpected error occurred: $e",
        };
      }
    }
  }

  /// PATCH request
  Future<dynamic> deleteRequest({required String endpoints}) async {
    try {
      log("\n\n\n\nurl :${ApiEndpoints.baseUrl}/$endpoints \n\n\n\n");
      final response = await _dio.delete(
        '/$endpoints',
        options: Options(
          headers: headers ?? {"Content-Type": "multipart/form-data"},
        ),
      );

      debugPrint("delete Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        // Return the user-friendly error string
        return {"success": false, "message": ErrorHandle.handleDioError(e)};
      } else {
        return {
          "success": false,
          "message": "An unexpected error occurred: $e",
        };
      }
    }
  }
}