import 'package:onpause/shared/utils/get_tokens.dart';

import '../../../shared/api/instances/classic_instance.dart';
import '../model/affirmation.dart';

Future<Affirmation> fetchAffirmation() async {
  final tokens = await getTokens();
  return Affirmation.fromJson((await getClassicInstance(tokens.accessToken)
          .get('/affirmations?offset=${DateTime.now().timeZoneOffset.inHours}'))
      .data);
}
