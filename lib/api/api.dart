import 'package:dio/dio.dart';
import 'package:prismsync/global_vars.dart';
import 'package:prismsync/api/utilities.dart';

// JSON forms
import 'package:prismsync/api/json/login_form.dart';

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

// Documentation entry: CreateSession
// Entry point: POST /api/v1/session
// Example request (JSON):
// {
//   "username": "admin",
//   "password": "password"
// }
// Example response (JSON):
// {
//   "status": "ok",
//   "config": {...}, // a huge object describing the server's configuration as well as all the data stored
//   "data": {...}, // an object containing the fields "tokens" and "shares", not sure what they do)
//   "id": "afea659c89703c252097433e9bb25584422a00292bcd6f97", // session ID, should be passed with a X-Session-ID header
//   "provider": "local", // "default", "local" (used for admin users), "ldap", "link" (used for visitors), "none" (used for unknown users) and ""
//   "user": {...} // an object describing all the user info
// }
// TODO: double-check
// TODO: check for permissions and warn if there are any missing
Future<String?> logIn(String baseUrl, LoginForm loginForm) async {
  ResponseAttempt responseAttempt = await apiPost(
    '/api/v1/session',
    anonymous: true,
    baseUrl: baseUrl,
    data: loginForm.toJson(),
    options: Options(
      contentType: Headers.jsonContentType,
    ),
  );

  late Map<String, dynamic> responseData;
  try {
    responseData = responseDataOrError(responseAttempt);
  } on String catch (e) {
    return e;
  }

  GlobalVariables.inPublicMode = responseData['config']['public'];
  GlobalVariables.sessionId = responseData['id'];
  return null;
}

// Documentation entry: DeleteSession
// Entry point: DELETE /api/v1/session/:id
// Example request: N/A, the required parameter (id, being session ID) is in the URL
// Example response (JSON):
// TODO: double-check
// {
//   "status": "ok",
//   "id": "afea659c89703c252097433e9bb25584422a00292bcd6f97" // the ID passed
// }
Future<String?> logOut() async {
  ResponseAttempt responseAttempt = await apiDelete(
    '/api/v1/session/${GlobalVariables.sessionId}',
  );

  try {
    responseDataOrError(responseAttempt);
  } on String catch (e) {
    return e;
  }

  GlobalVariables.sessionId = null;
  return null;
}

// Documentation entry: SearchPhotos
// Entry point: GET /api/v1/photos
// TODO: check on actual instance
// Example request (query parameters? check):
// /api/v1/photos?type=video|live|animated&label=cat
// See https://docs.photoprism.app/user-guide/search/filters/#filter-reference for available values
// Example successful response (JSON?):
// TODO: successful response
// TODO: change dynamic to something more concrete
Future<dynamic> getPhotos({
  String? query,
  String? scope,
  // TODO: use pages instead?
  required int count,
  int? offset,
  String? order,
}) async {
  ResponseAttempt responseAttempt = await apiGet('/api/v1/photos',
      // TODO: maybe the null checks and toString conversion are excessive?
      queryParameters: {
        if (query != null) 'q': query,
        if (scope != null) 's': scope,
        'count': count.toString(),
        if (offset != null) 'offset': offset.toString(),
        if (order != null) 'order': order,
      });

  late Map<String, dynamic> responseData;
  try {
    responseData = responseDataOrError(responseAttempt);
  } on String catch (e) {
    return e;
  }

  // TODO: process response
  return responseData;
}

// TODO: add other methods, check how they're implemented