import 'package:dio/dio.dart';
import './get_tokens.dart';
import './set_tokens.dart';

import '../api/models/auth_response.dart';

Future<AuthResponse> refreshTokens(String refreshToken) async =>
    AuthResponse.fromJson((await Dio(BaseOptions(
                baseUrl: 'http://10.0.2.2:3000',
                headers: {'Authorization': 'Bearer $refreshToken'}))
            .get('/auth/refresh'))
        .data);

Future<T> withRefreshTokens<T>(Function request) async {
  print('refreshing');
  final tokens = await getTokens();
  if (tokens.expiresIn > 0 &&
      DateTime.now().millisecondsSinceEpoch >= tokens.expiresIn * 1000) {
    await setTokens(await refreshTokens(tokens.refreshToken));
  }
  return request();
}
