import '../../../shared/api/auth_instance.dart';

class AuthResponse {
  AuthResponse({required this.token});

  String token;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    if (json case {"token": String token}) return AuthResponse(token: token);
    throw const FormatException("invalid json");
  }
}

class LoginRequest {
  LoginRequest({required this.email, required this.password});

  String email, password;

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    if (json case {"email": String email, "password": String password}) {
      return LoginRequest(email: email, password: password);
    }
    throw const FormatException("invalid json");
  }

  Map<String, dynamic> toJson() {
    return {"email": email, "hashed_password": password};
  }
}

Future<AuthResponse> login(LoginRequest body) async {
  return AuthResponse.fromJson(
      (await authInstance.post("/login", data: body.toJson())).data
          as Map<String, dynamic>);
}
