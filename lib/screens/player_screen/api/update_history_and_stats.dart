import '../../../shared/api/instances/classic_instance.dart';
import '../../../shared/utils/get_tokens.dart';
import '../../home_screen/api/fetch_user.dart';

class UpdateRequest {
  UpdateRequest({required this.id, required this.time});

  final int id, time;

  Map<String, dynamic> toJson() {
    return {'id': id, 'time': time};
  }
}

Future<User> updateHistoryAndStats(int id, int time) async {
  final tokens = await getTokens();
  return User.fromJson((await getClassicInstance(tokens.accessToken).patch(
          '/meditations/update',
          data: UpdateRequest(id: id, time: time).toJson()))
      .data);
}
