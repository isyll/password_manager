import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:password_manager/core/http/api_config.dart';
import 'package:password_manager/core/http/request_method.dart';

class RequestHandler {
  static Future<String?> Function()? getAccessTokenFn;
  static Future<String?> Function()? refreshTokenFn;
  static String Function()? getLocaleFn;

  /// The [urlString] is retrieved from api object.
  /// The [method] is obtained using object.value.method.
  /// For authorized requests, set [authorized] to true.
  /// The [body] parameter stores the request parameters.
  /// The [headersCustom] parameter holds custom header values.
  /// For [RequestMethod.get] and [RequestMethod.delete], append the ID to the [urlString].
  static Future<ResponseModel> call(String urlString, RequestMethod method,
      {bool authorized = true,
      RequestBody? body,
      ApiHeaderType? headersCustom}) async {
    try {
      if (kDebugMode) {
        print(urlString);
        print(json.encode(body));
      }

      // set the Headers
      final headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
        'Cache-Control': 'no-cache',
        if (headersCustom != null) ...headersCustom,
      };

      if (getLocaleFn != null) {
        headers['Accept-Language'] = getLocaleFn!();
      }

      if (authorized) {
        final token = await getAccessTokenFn!();
        headers['Authorization'] = 'Bearer $token';
      }

      // Api call
      final response = await method.apiCall(Uri.parse(urlString),
          headers: headers, body: json.encode(body));

      // Setting Response Body
      final ResponseBody responseBody =
          json.decode(utf8.decode(response.bodyBytes));

      return ResponseModel.fromMap(responseBody);
    } catch (e) {
      if (kDebugMode) {
        print('There is an issue with : $urlString');
        print(e);
      }
      rethrow;
    }
  }
}

class ResponseModel {
  final String? message;
  final bool status;
  final int statusCode;
  final Map<String, dynamic>? data;
  final Map<String, String>? errors;

  const ResponseModel(
      {this.message,
      required this.status,
      required this.statusCode,
      this.data,
      this.errors});

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
        message: map['message'] as String?,
        status: map['status'] as bool,
        statusCode: map['status_code'] as int,
        data: map['data'] as Map<String, dynamic>?,
        errors: (map['errors'] as Map<String, dynamic>?)
            ?.map((key, value) => MapEntry(key, value.toString())));
  }

  /// Convert the ResponseModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'status': status,
      'status_code': statusCode,
      'data': data,
      'errors': errors,
    };
  }
}
