import 'package:dio/dio.dart';

Dio getClassicInstance(String accessToken) {
  return Dio(BaseOptions(
      baseUrl: "http://10.0.2.2:3000",
      headers: {"Authorization": "Bearer $accessToken"}));
}
