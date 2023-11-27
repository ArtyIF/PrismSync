import 'package:dio/dio.dart';
import 'package:prismsync/global_vars.dart';

final dio = Dio(
  BaseOptions(
    validateStatus: (_) => true, // to avoid an exception on error statuses
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

void _checkValidCall() {
  if (GlobalVariables.baseUrl == null) {
    throw Exception("baseUrl is null. Try calling logIn.");
  }
  if (GlobalVariables.sessionId == null && !GlobalVariables.inPublicMode) {
    throw Exception(
        "This server requires authentication, and the client is currently unauthenticated. Try calling logIn.");
  }
}

// https://pkg.go.dev/github.com/photoprism/photoprism/internal/api?utm_source=godoc

// Documentation entry: CreateSession
// Entry point: POST /api/v1/session
// Example request (JSON):
// {
//   "username": "admin",
//   "password": "password"
// }
// Example successful response (JSON):
// {
//   "status": "ok",
//   "config": {...}, // a huge object describing the server's configuration as well as all the data stored
//   "data": {...}, // an object containing the fields "tokens" and "shares", not sure what they do)
//   "id": "afea659c89703c252097433e9bb25584422a00292bcd6f97", // session ID, should be passed with a X-Session-ID header
//   "provider": "local", // "default", "local" (used for admin users), "ldap", "link" (used for visitors), "none" (used for unknown users) and ""
//   "user": {...} // an object describing all the user info
// }
// TODO: double-check
// Example failed response (JSON):
// {
//   "error": "..." // localized error goes here
// }
Future<String?> logIn(String baseUrl, String username, String password) async {
  if (!(Uri.tryParse(baseUrl)?.isAbsolute ?? false)) {
    return "Invalid URL";
  }

  // TODO: catch exceptions, maybe even make a separate safe function
  Response<Map<String, dynamic>> response = await dio.post(
    "$baseUrl/api/v1/session",
    data: {
      "username": username,
      "password": password,
    },
    options: Options(
      contentType: Headers.jsonContentType,
    ),
  );

  if (response.data!.containsKey("error")) {
    return response.data!["error"];
  }

  GlobalVariables.inPublicMode = response.data!["config"]["public"];
  GlobalVariables.sessionId = response.data!["id"];
  GlobalVariables.baseUrl = baseUrl;
  return null;
}

// Documentation entry: DeleteSession
// Entry point: DELETE /api/v1/session/:id
// Example request: N/A, the parameter is part of the URL
// Example successful response (JSON):
// TODO: double-check
// {
//   "status": "ok",
//   "id": "afea659c89703c252097433e9bb25584422a00292bcd6f97" // the ID passed
// }
// Example failed response (JSON):
// {
//   "error": "..." // error goes here
// }
Future<String?> logOut() async {
  _checkValidCall();
  Response<Map<String, dynamic>> response = await dio.delete(
    "${GlobalVariables.baseUrl}/api/v1/session/${GlobalVariables.sessionId}",
    options: Options(
      headers: {
        "X-Session-ID": GlobalVariables.sessionId,
      },
    ),
  );

  if (response.data!.containsKey("error")) {
    return response.data!["error"];
  }

  GlobalVariables.sessionId = null;
  return null;
}
