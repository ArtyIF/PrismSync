import 'package:dio/dio.dart';
import 'package:prismsync/api.dart';
import 'package:prismsync/global_vars.dart';

void checkValidCall() {
  if (GlobalVariables.baseUrl == null) {
    throw Exception('baseUrl is null. Try calling logIn.');
  }
  if (GlobalVariables.sessionId == null && !GlobalVariables.inPublicMode) {
    throw Exception(
        'This server requires authentication, and the client is currently unauthenticated. Try calling logIn.');
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
  String path, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  // TODO: do we need the other parameters? do we even need cancelToken?
  // if we do, check other _api* methods
}) async {
  try {
    return ResponseAttempt(
      response: await dio.request<Map<String, dynamic>>(
        path,
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
              response: e.response as Response<Map<String, dynamic>>?);
        case DioExceptionType.connectionTimeout:
          return ResponseAttempt(exception: 'Connection timed out. Check your internet connection and server configuration.');
        case DioExceptionType.sendTimeout:
          return ResponseAttempt(exception: 'Sending data timed out. Check your internet connection and server configuration.');
        case DioExceptionType.receiveTimeout:
          return ResponseAttempt(exception: 'Receiving data timed out. Check your internet connection and server configuration.');
        case DioExceptionType.badCertificate:
          return ResponseAttempt(exception: 'Incorrect cerificate. Check your server configuration and your device\'s installed certificates.');
        case DioExceptionType.cancel:
          return ResponseAttempt(exception: 'Request cancelled');
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
          return ResponseAttempt(exception: 'Connection error: $reason');
        case DioExceptionType.unknown:
          return ResponseAttempt(exception: e.error.toString());
      }
    } else {
      return ResponseAttempt(exception: e.toString());
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
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('GET', options),
    cancelToken: cancelToken,
  );
}

Future<ResponseAttempt> apiPost(
  String path, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('POST', options),
    cancelToken: cancelToken,
  );
}

Future<ResponseAttempt> apiPut(
  String path, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('PUT', options),
    cancelToken: cancelToken,
  );
}

Future<ResponseAttempt> apiHead(
  String path, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('HEAD', options),
    cancelToken: cancelToken,
  );
}

Future<ResponseAttempt> apiDelete(
  String path, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('DELETE', options),
    cancelToken: cancelToken,
  );
}

Future<ResponseAttempt> apiPatch(
  String path, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  return await _apiRequest(
    path,
    data: data,
    queryParameters: queryParameters,
    options: _addMethodToOptions('PATCH', options),
    cancelToken: cancelToken,
  );
}
