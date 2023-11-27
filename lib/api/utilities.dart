import 'package:dio/dio.dart';
import 'package:prismsync/api/api.dart';
import 'package:prismsync/global_vars.dart';

void _checkValidCall(bool anonymous) {
  if (GlobalVariables.baseUrl == null) {
    throw 'Base URL isn\'t set';
  }
  if (!Uri.parse(GlobalVariables.baseUrl!).isAbsolute) {
    // TODO: link to a better explanation
    throw 'Base URL is invalid. Examples of a valid URL: http://example.com:8080, http://192.168.1.2:2342';
  }
  if (!anonymous &&
      GlobalVariables.sessionId == null &&
      !GlobalVariables.inPublicMode) {
    throw 'This server requires authentication, and the client is currently unauthenticated';
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
  bool anonymous = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  void Function(int, int)? onSendProgress,
  void Function(int, int)? onReceiveProgress,
}) async {
  if (baseUrl != null) {
    GlobalVariables.baseUrl = baseUrl;
  }

  try {
    _checkValidCall(anonymous);
  } on String catch (e) {
    return ResponseAttempt(exception: e);
  }

  try {
    return ResponseAttempt(
      response: await dio.request<Map<String, dynamic>>(
        '$baseUrl$apiPath',
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
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

Options _adaptOptions(String method, Options? options) {
  options ??= Options();

  options.method = method;

  if (GlobalVariables.sessionId != null) {
    options.headers ??= {};
    options.headers!['X-Session-ID'] = GlobalVariables.sessionId;
  }

  return options;
}

Future<ResponseAttempt> apiGet(
  String path, {
  bool anonymous = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  void Function(int, int)? onSendProgress,
  void Function(int, int)? onReceiveProgress,
}) async {
  return await _apiRequest(
    path,
    anonymous: anonymous,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _adaptOptions('GET', options),
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );
}

Future<ResponseAttempt> apiPost(
  String path, {
  bool anonymous = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  void Function(int, int)? onSendProgress,
  void Function(int, int)? onReceiveProgress,
}) async {
  return await _apiRequest(
    path,
    anonymous: anonymous,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _adaptOptions('POST', options),
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );
}

Future<ResponseAttempt> apiPut(
  String path, {
  bool anonymous = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  void Function(int, int)? onSendProgress,
  void Function(int, int)? onReceiveProgress,
}) async {
  return await _apiRequest(
    path,
    anonymous: anonymous,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _adaptOptions('PUT', options),
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );
}

Future<ResponseAttempt> apiHead(
  String path, {
  bool anonymous = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  void Function(int, int)? onSendProgress,
  void Function(int, int)? onReceiveProgress,
}) async {
  return await _apiRequest(
    path,
    anonymous: anonymous,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _adaptOptions('HEAD', options),
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );
}

Future<ResponseAttempt> apiDelete(
  String path, {
  bool anonymous = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  void Function(int, int)? onSendProgress,
  void Function(int, int)? onReceiveProgress,
}) async {
  return await _apiRequest(
    path,
    anonymous: anonymous,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _adaptOptions('DELETE', options),
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );
}

Future<ResponseAttempt> apiPatch(
  String path, {
  bool anonymous = false,
  String? baseUrl,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
  void Function(int, int)? onSendProgress,
  void Function(int, int)? onReceiveProgress,
}) async {
  return await _apiRequest(
    path,
    anonymous: anonymous,
    baseUrl: baseUrl,
    data: data,
    queryParameters: queryParameters,
    options: _adaptOptions('PATCH', options),
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );
}

Map<String, dynamic> responseDataOrError(ResponseAttempt responseAttempt) {
  if (responseAttempt.exception != null) {
    throw responseAttempt.exception!;
  }
  if (responseAttempt.response!.data == null) {
    throw 'No data in response';
  }
  if (responseAttempt.response!.data!.containsKey('error')) {
    throw responseAttempt.response!.data!['error'].toString();
  }
  return responseAttempt.response!.data!;
}
