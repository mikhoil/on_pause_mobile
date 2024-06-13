import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearTokens() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('accessToken');
  prefs.remove('refreshToken');
  prefs.remove('expiresIn');
}
