import '../../../shared/utils/get_tokens.dart';
import '../../../shared/api/instances/classic_instance.dart';
import '../../../entities/practice/model/practice.dart';

Future<List<Practice>> fetchPractices() async {
  final tokens = await getTokens();
  return List<Practice>.from(
      (await (getClassicInstance(tokens.accessToken)).get('/practices'))
          .data
          .map((practice) => Practice.fromJson(practice)));
}
