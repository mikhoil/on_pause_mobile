import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken() async {
  return (await SharedPreferences.getInstance()).getString("token");
}
