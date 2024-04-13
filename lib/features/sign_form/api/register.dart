import 'package:onpause/features/sign_form/api/login.dart';
import 'package:onpause/shared/api/auth_instance.dart';

class RegisterRequest {
  RegisterRequest(
      {required this.email, required this.username, required this.password});

  String email, username, password;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          "email": String email,
          "password": String password,
          "username": String username
        }) {
      return RegisterRequest(
          email: email, password: password, username: username);
    }
    throw const FormatException("invalid json");
  }

  Map<String, dynamic> toJson() {
    return {"email": email, "username": username, "hashed_password": password};
  }
}

Future<AuthResponse> register(RegisterRequest body) async {
  return AuthResponse.fromJson(
      (await authInstance.post('/register', data: body.toJson())).data);
}
