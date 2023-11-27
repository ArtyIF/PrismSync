import 'package:dio/dio.dart';
import 'package:prismsync/api.dart';
import 'package:prismsync/global_vars.dart';

void _checkValidCall(bool skipSessionCheck) {
  if (GlobalVariables.baseUrl == null) {
    throw Exception('Base URL isn\'t set');
  }
  if (!Uri.parse(GlobalVariables.baseUrl!).isAbsolute) {
    // TODO: link to a better explanation
    throw Exception(
        'Base URL is invalid. Examples of a valid URL: http://example.com:8080, http://192.168.1.2:2342');
  }
  if (!skipSessionCheck && GlobalVariables.sessionId == null && !GlobalVariables.inPublicMode) {
    throw Exception(
        'This server requires authentication, and the client is currently unauthenticated');
  }
}

class ResponseAttempt {
  final Response<Map<String, dynamic>>? response;
  final String? exception;

  ResponseAttempt({
    this.response,
    this.exception,
  });
}

Future<ResponseAttempt> _apiRequest(
  String apiPath, {
  bool skipSessionCheck = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  // TODO: do we need the other parameters? do we even need cancelToken?
  // if we do, update other api* methods
}) async {
  if (baseUrl != null) {
    GlobalVariables.baseUrl = baseUrl;
  }

  try {
    _checkValidCall(skipSessionCheck);
  } on Exception catch (e) {
    return ResponseAttempt(exception: e.toString());
  }

  try {
    return ResponseAttempt(
      response: await dio.request<Map<String, dynamic>>(
        '$baseUrl$apiPath',
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  } catch (e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.badResponse:
          return ResponseAttempt(
            response: e.response as Response<Map<String, dynamic>>?,
          );
        case DioExceptionType.connectionTimeout:
          return ResponseAttempt(
            exception:
                'Connection timed out. Check your internet connection and server configuration.',
          );
        case DioExceptionType.sendTimeout:
          return ResponseAttempt(
            exception:
                'Sending data timed out. Check your internet connection and server configuration.',
          );
        case DioExceptionType.receiveTimeout:
          return ResponseAttempt(
            exception:
                'Receiving data timed out. Check your internet connection and server configuration.',
          );
        case DioExceptionType.badCertificate:
          return ResponseAttempt(
            exception:
                'Incorrect cerificate. Check your server configuration and your device\'s installed certificates.',
          );
        case DioExceptionType.cancel:
          return ResponseAttempt(
            exception: 'Request cancelled',
          );
        case DioExceptionType.connectionError:
          // Dio doesn't provide a reason separately, so we have to remove unnecessary parts
          String reason = e.message!;
          reason = reason
              .replaceFirst(
                'The connection errored:',
                '',
              )
              .replaceFirst(
                'This indicates an error which most likely cannot be solved by the library.',
                '',
              )
              .trim();
          return ResponseAttempt(
            exception: 'Connection error: $reason',
          );
        case DioExceptionType.unknown:
          return ResponseAttempt(
            exception: e.error.toString(),
          );
      }
    } else {
      return ResponseAttempt(
        exception: e.toString(),
      );
    }
  }
}

Options _addMethodToOptions(String method, Options? options) {
  options ??= Options();
  options.method = method;
  return options;
}

Future<ResponseAttempt> apiGet(
  String path, {
  bool skipSessionCheck = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    skipSessionCheck: skipSessionCheck,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('GET', options),
    cancelToken: cancelToken,
  );
}

Future<ResponseAttempt> apiPost(
  String path, {
  bool skipSessionCheck = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    skipSessionCheck: skipSessionCheck,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('POST', options),
    cancelToken: cancelToken,
  );
}

Future<ResponseAttempt> apiPut(
  String path, {
  bool skipSessionCheck = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    skipSessionCheck: skipSessionCheck,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('PUT', options),
    cancelToken: cancelToken,
  );
}

Future<ResponseAttempt> apiHead(
  String path, {
  bool skipSessionCheck = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    skipSessionCheck: skipSessionCheck,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('HEAD', options),
    cancelToken: cancelToken,
  );
}

Future<ResponseAttempt> apiDelete(
  String path, {
  bool skipSessionCheck = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    skipSessionCheck: skipSessionCheck,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('DELETE', options),
    cancelToken: cancelToken,
  );
}

Future<ResponseAttempt> apiPatch(
  String path, {
  bool skipSessionCheck = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    skipSessionCheck: skipSessionCheck,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('PATCH', options),
    cancelToken: cancelToken,
  );
}
