import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/fetch_user.dart';

Query<User, Error> useUser(String token) {
  return useQuery(token, fetchUser, onData: (user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("hasSubscription", user.hasSubscribe);
  });
}