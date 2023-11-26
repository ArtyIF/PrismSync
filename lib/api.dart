import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    validateStatus: (_) => true, // to avoid an exception on error statuses
  ),
);

class PhotoPrismApiReturn {
  PhotoPrismApiReturn(this.baseResponse) {
    status = baseResponse.statusCode!;
    transformedResult = baseResponse.data!;
  }

  Response<Map<String, dynamic>> baseResponse;
  late int status;
  late Map<String, dynamic> transformedResult;
}

// Entry point: POST /api/v1/session
// Example request (JSON):
// {
//   "username": "admin",
//   "password": "password"
// }
// Example response (JSON):
// {
//   "config": {...}, // a huge object describing the server's configuration as well as all the data stored
//   "data": {...}, // an object containing the fields "tokens" and "shares", not sure what they do)
//   "id": "afea659c89703c252097433e9bb25584422a00292bcd6f97", // session ID
//   "provider": "local", // "default", "local" (used for admin users), "ldap", "link" (used for visitors), "none" (used for unknown users) and ""
//   "status": "ok", // ignore, on error it returns a JSON object with only the "error" field in it containing the (localized) error
//   "user": {...} // an object describing all the user info
// }
Future<PhotoPrismApiReturn> logIn(
  String baseUrl,
  String username,
  String password,
) async {
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
  return PhotoPrismApiReturn(response);
}
