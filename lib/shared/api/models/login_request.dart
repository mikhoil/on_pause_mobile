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
    return {"email": email, "password": password};
  }
}