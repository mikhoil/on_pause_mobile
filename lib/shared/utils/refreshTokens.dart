import 'package:dio/dio.dart';
import './getTokens.dart';
import './setTokens.dart';

import '../api/models/auth_response.dart';

Future<AuthResponse> refreshTokens(String refreshToken) async =>
    AuthResponse.fromJson((await Dio(BaseOptions(
                baseUrl: 'http://10.0.2.2:3000',
                headers: {'Authorization': 'Bearer $refreshToken'}))
            .get('/auth/refresh'))
        .data);

Future<T> withRefreshTokens<T>(Function request) async {
  final AuthResponse(refreshToken: refreshToken, expiresIn: expiresIn) =
      await getTokens();
  if (expiresIn > 0 &&
      DateTime.now().millisecondsSinceEpoch >= expiresIn * 1000) {
    await setTokens(await refreshTokens(refreshToken));
  }
  return request();
}
