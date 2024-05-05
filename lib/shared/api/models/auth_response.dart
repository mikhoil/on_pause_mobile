class AuthResponse {
  AuthResponse(
      {required this.accessToken,
        required this.refreshToken,
        required this.expiresIn});

  String accessToken, refreshToken;
  int expiresIn;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    if (json
    case {
    "accessToken": String accessToken,
    "refreshToken": String refreshToken,
    "expiresIn": int expiresIn
    }) {
      return AuthResponse(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresIn: expiresIn);
    }
    throw const FormatException("invalid json");
  }
}