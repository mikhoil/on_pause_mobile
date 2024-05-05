import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/auth_response.dart';

Future<void> setTokens(AuthResponse authResponse) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('accessToken', authResponse.accessToken);
  prefs.setString('refreshToken', authResponse.refreshToken);
  prefs.setInt('expiresIn', authResponse.expiresIn);
}
