import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import '../../../shared/utils/refresh_tokens.dart';
import '../../../entities/practice/model/practice.dart';
import '../api/fetch_practices.dart';

Query<List<Practice>, Error> usePractices() =>
    useQuery("practices", () => withRefreshTokens(fetchPractices));
