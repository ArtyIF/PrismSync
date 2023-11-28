import 'package:dio/dio.dart';
import 'package:prismsync/api/json/photo.dart';
import 'package:prismsync/global_vars.dart';
import 'package:prismsync/api/utilities.dart';

// JSON forms
import 'package:prismsync/api/json/create_session.dart';

final dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(
      seconds: 30,
    ),
    sendTimeout: const Duration(
      seconds: 30,
    ),
    receiveTimeout: const Duration(
      seconds: 30,
    ),
  ),
);

// https://pkg.go.dev/github.com/photoprism/photoprism/internal/api?utm_source=godoc

// When errors happen, the following JSON object is usually returned:
// {
//   "error": "Localized error message goes here"
// }

// TODO: check for permissions and warn if there are any missing
Future<void> createSession(String baseUrl, CreateSessionRequest data) async {
  ResponseAttempt responseAttempt = await apiPost(
    '/api/v1/session',
    anonymous: true,
    baseUrl: baseUrl,
    data: data.toJson(),
    options: Options(
      contentType: Headers.jsonContentType,
    ),
  );

  late Map<String, dynamic> responseData;
  try {
    responseData = responseDataOrError(responseAttempt);
  } on String {
    rethrow;
  }

  CreateSessionResponse response = CreateSessionResponse.fromJson(responseData);

  GlobalVariables.inPublicMode = response.config!.public!;
  GlobalVariables.sessionId = response.id;
}

Future<void> deleteSession() async {
  ResponseAttempt responseAttempt = await apiDelete(
    '/api/v1/session/${GlobalVariables.sessionId}',
  );

  try {
    responseDataOrError(responseAttempt);
  } on String {
    rethrow;
  }

  GlobalVariables.sessionId = null;
}

// TODO: check on actual instance
// TODO: change dynamic to something more concrete
Future<List<Photo>> searchPhotos({
  String? query,
  String? scope,
  required int count,
  int? offset,
  String? order,
}) async {
  ResponseAttempt responseAttempt = await apiGet(
    '/api/v1/photos',
    queryParameters: {
      if (query != null) 'q': query,
      if (scope != null) 's': scope,
      'count': count.toString(),
      if (offset != null) 'offset': offset.toString(),
      if (order != null) 'order': order,
    },
  );

  late List<dynamic> responseData;
  try {
    responseData = responseDataOrError(responseAttempt);
  } on String {
    rethrow;
  }

  return photoListFromJson(responseData);
}

// TODO: add other methods, check how they're implemented