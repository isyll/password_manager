import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:password_manager/core/constants/app_config.dart';
import 'package:password_manager/core/http/api_config.dart';
import 'package:password_manager/core/http/apis/auth_api.dart';
import 'package:password_manager/core/http/request_method.dart';
import 'package:password_manager/models/auth/signin_response.dart';
import 'package:password_manager/services/preferences_service.dart';
import 'package:password_manager/services/secure_storage.dart';

class RequestHandler {
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

      final token = await SecureStorage.getAccessToken();
      final locale = PreferencesService.getLocale() ??
          AppConfig.defaultLocale.languageCode;

      // set the Headers
      final headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
        'Accept-Language': locale,
        'Cache-Control': 'no-cache',
        if (authorized) 'Authorization': 'Bearer $token',
        if (headersCustom != null) ...headersCustom,
      };

      // Api call
      var response = await method.apiCall(Uri.parse(urlString),
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

  static Future<String?> refreshToken() async {
    final response = await AuthApi.refreshToken();

    if (response.status) {
      final data = SigninResponse.fromMap(response.data!);
      await SecureStorage.saveTokens(data.accessToken, data.refreshToken);
      return data.accessToken;
    }
    return null;
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
        message: map['message'],
        status: map['status'],
        statusCode: map['status_code'],
        data: map['data'],
        errors: map['errors']);
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
