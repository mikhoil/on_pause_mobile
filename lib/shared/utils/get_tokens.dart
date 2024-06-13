import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/auth_response.dart';

Future<AuthResponse> getTokens() async {
  final prefs = await SharedPreferences.getInstance();
  print('tokens: ${prefs.getString('refreshToken')}');
  return AuthResponse(
      accessToken: prefs.getString("accessToken") ?? '',
      refreshToken: prefs.getString("refreshToken") ?? '',
      expiresIn: prefs.getInt("expiresIn") ?? -1);
}
