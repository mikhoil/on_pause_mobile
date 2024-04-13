import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Dio> getClassicInstance() async {
  final prefs = await SharedPreferences.getInstance();
  return Dio(BaseOptions(
      baseUrl: "http://10.0.2.2:3000",
      headers: {"Authorization": prefs.get("token")}));
}
