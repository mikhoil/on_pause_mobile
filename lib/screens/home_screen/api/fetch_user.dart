import '../../../shared/api/classic_instance.dart';

class User {
  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.hasSubscribe});

  String email, username;
  int id;
  bool hasSubscribe;

  factory User.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          "id": int id,
          "email": String email,
          "username": String username,
          "subscriber": bool subscriber
        }) {
      return User(
          id: id, username: username, email: email, hasSubscribe: subscriber);
    }
    throw const FormatException("invalid json");
  }
}

Future<User> fetchUser() async {
  return User.fromJson(
      (await (await getClassicInstance()).get('/auth/me')).data);
}
