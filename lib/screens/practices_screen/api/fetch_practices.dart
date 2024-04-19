import '../../../shared/api/classic_instance.dart';
import '../../../entities/practice/model/practice.dart';

Future<List<Practice>> fetchPractices() async {
  return List<Practice>.from(
      (await (await getClassicInstance()).get('/practices'))
          .data
          .map((practice) => Practice.fromJson(practice)));
}
