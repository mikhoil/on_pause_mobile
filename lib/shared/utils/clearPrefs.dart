import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearPrefs() async {
  (await SharedPreferences.getInstance()).clear();
}
