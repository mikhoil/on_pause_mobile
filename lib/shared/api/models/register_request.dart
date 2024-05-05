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
    return {"email": email, "username": username, "password": password};
  }
}