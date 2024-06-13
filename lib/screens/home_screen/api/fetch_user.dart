import 'dart:ffi';

import 'package:onpause/shared/utils/get_tokens.dart';

import '../../../entities/history_item/model/history_item.dart';
import '../../../shared/api/instances/classic_instance.dart';

class User {
  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.hasSubscribe,
      required this.dailyStrick,
      required this.totalTime,
      required this.sessionCount,
      required this.progress,
      required this.history});

  String email, username;
  int id, dailyStrick, totalTime, sessionCount;
  double progress;
  bool hasSubscribe;
  List<HistoryItem> history;

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    if (json
        case {
          "id": int id,
          "email": String email,
          "username": String username,
          "subscriber": bool subscriber,
          "daily_strick": int dailyStrick,
          "total_time": int totalTime,
          "total_sessions": int sessionCount,
          "progress": double progress,
        }) {
      return User(
          id: id,
          username: username,
          email: email,
          hasSubscribe: subscriber,
          dailyStrick: dailyStrick,
          totalTime: totalTime,
          sessionCount: sessionCount,
          progress: progress,
          history: List<HistoryItem>.from(json['history'].map((historyItem) =>
              HistoryItem.fromJson(historyItem as Map<String, dynamic>))));
    }
    throw const FormatException("invalid json");
  }
}

Future<User> fetchUser() async {
  final tokens = await getTokens();
  return User.fromJson(
      (await getClassicInstance(tokens.accessToken).get('/auth/me')).data);
}
