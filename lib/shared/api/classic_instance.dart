import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Dio> getClassicInstance() async {
  final prefs = await SharedPreferences.getInstance();
  return Dio(BaseOptions(
      baseUrl: "http://10.0.2.2:3000",
      headers: {"Authorization": "Bearer ${prefs.get("token")}"}));
}

// final box = GetStorage();
// final classicInstance = Dio(BaseOptions(baseUrl: "http://10.0.2.2:3000", headers: {
//   "Authorization": "Bearer ${box.read("token")}"
// });