import 'package:password_manager/core/constants/app_config.dart';
import 'package:password_manager/core/http/request_handler.dart';
import 'package:password_manager/core/http/request_method.dart';

const String baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: AppConfig.baseUrl,
);

/// Api Header
typedef ApiHeaderType = Map<String, String>;

typedef RequestBody = Map<String, dynamic>;

/// Response Body
typedef ResponseBody = Map<String, dynamic>;

/// Base class for API configuration, containing information such as path,
/// method, authorization, and module.
/// The [module] attribute denotes the API's base path, specifying its category.
abstract class ApiConfig {
  final String path;
  final RequestMethod method;
  final bool isAuth;
  final String module;

  const ApiConfig(
      {required this.path,
      required this.method,
      this.isAuth = true,
      this.module = ''});

  /// Sends an HTTP request to the specified URL with the given parameters.
  ///
  /// This function takes a URL and an optional map of parameters, constructs
  /// the request, and sends it. It returns the response from the server.
  ///
  /// Parameters:
  /// - `urlParam` (String?): An optional URL parameter.
  /// - `body` (RequestBody?): An optional request body.
  /// - `headersCustom` (ApiHeaderType?): An optional map of custom headers.
  /// - `queryParams` (Map&lt;String, String?&gt;?): An optional map of query parameters.
  ///
  /// Returns:
  /// - `Future<ResponseModel>`: A future that completes with the server's response.
  Future<ResponseModel> sendRequest(
      {String? urlParam,
      RequestBody? body,
      ApiHeaderType? headersCustom,
      Map<String, String?>? queryParams}) {
    final url = _getUrlString(queryParams, urlParam);

    return RequestHandler.call(url, method,
        authorized: isAuth, body: body, headersCustom: headersCustom);
  }

  /// Constructs a query string from the given parameters.
  ///
  /// This function takes a map of key-value pairs and converts them into a
  /// query string format, where each key-value pair is joined by an '=' and
  /// each pair is separated by an '&'. The resulting string can be used as
  /// part of a URL to pass parameters to a web service.
  ///
  /// If the map is empty, an empty string is returned.
  ///
  /// Example:
  /// ```dart
  /// final params = {'name': 'John', 'age': '30'};
  /// final queryString = _buildQueryString(params);
  /// print(queryString); // Output: 'name=John&age=30'
  /// ```
  ///
  /// - Parameters:
  ///   - params: A map containing the key-value pairs to be converted.
  ///
  /// - Returns: A string representing the query parameters in URL-encoded format.
  String _buildQueryString(Map<String, String?>? queryParams) {
    if (queryParams == null || queryParams.isEmpty) {
      return '';
    }
    final params = queryParams.entries.map((param) {
      if (param.value == null) return null;
      return '${param.key}=${Uri.encodeComponent(param.value!.trim())}';
    }).where((param) => param != null);

    return '?${params.join('&')}';
  }

  /// Constructs a URL string based on the provided parameters.
  ///
  /// Example usage:
  /// ```dart
  /// String url = _getUrlString({'key1': 'value1', 'key2': 'value2'}, 'param');
  /// print(url); // Output: ?key1=value1&key2=value2
  /// ```
  ///
  /// - Parameters:
  ///   - queryParams: A map containing the key-value pairs to be converted.
  ///   - urlParam: A string containing a URL parameter.
  ///
  /// - Returns: A string representing the query parameters in URL-encoded format.
  String _getUrlString(Map<String, String?>? queryParams, String? urlParam) {
    final queryString = _buildQueryString(queryParams);
    final urlString = _joinUrlSegments(urlParam);
    return '$urlString$queryString';
  }

  /// Joins multiple URL segments into a single URL string.
  ///
  /// This function takes all segments defined in ApiConfig and concatenates
  /// them into a single URL string, ensuring that there are no duplicate
  /// slashes between segments. It also handles leading and trailing slashes
  /// appropriately.
  ///
  /// Example:
  /// ```dart
  /// final urlParam = 12;
  /// final url = _joinUrlSegments(urlParam);
  /// print(url); // Output: http://example.com/users/12
  /// ```
  ///
  /// - Parameter segments: A list of URL segments to be joined.
  /// - Returns: A single URL string formed by concatenating the input segments.
  String _joinUrlSegments(String? urlParam) {
    final segments = [baseUrl, module, path, urlParam ?? ''];

    return segments
        .map((segment) => segment.trim())
        .where((segment) => segment.isNotEmpty)
        .map((segment) => segment.replaceAll(RegExp(r'^/+|/+\$'), ''))
        .join('/')
        .replaceAll(RegExp(r'(?<!:)//'), '/');
  }
}
