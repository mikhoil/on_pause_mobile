import '../../../shared/api/instances/classic_instance.dart';
import '../../../shared/utils/get_tokens.dart';
import '../../home_screen/api/fetch_user.dart';

Future<User> subscriptionOn() async {
  final tokens = await getTokens();
  return User.fromJson((await getClassicInstance(tokens.accessToken)
          .patch('/users/subscription/on'))
      .data);
}

Future<User> subscriptionOff() async {
  final tokens = await getTokens();
  return User.fromJson((await getClassicInstance(tokens.accessToken)
          .patch('/users/subscription/off'))
      .data);
}
