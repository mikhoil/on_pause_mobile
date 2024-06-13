import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import '../api/fetch_affirmation.dart';
import '../../../shared/utils/refresh_tokens.dart';

import '../model/affirmation.dart';

Query<Affirmation, Error> useAffirmation() =>
    useQuery('affirmations', () => withRefreshTokens(fetchAffirmation));
