import '../../../shared/api/instances/classic_instance.dart';
import '../../../shared/utils/get_tokens.dart';

Future<void> logout() async {
  final tokens = await getTokens();
  (await getClassicInstance(tokens.accessToken).get('/auth/logout')).data;
}
