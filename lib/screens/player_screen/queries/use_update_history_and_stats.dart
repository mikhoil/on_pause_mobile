import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import 'package:onpause/shared/utils/refresh_tokens.dart';
import '../../../screens/home_screen/api/fetch_user.dart';
import '../api/update_history_and_stats.dart';

Mutation<User, Error, int> useUpdateHistoryAndStats(int id) => useMutation(
    "update $id",
    (variables) =>
        withRefreshTokens(() => updateHistoryAndStats(id, variables)),
    refreshQueries: ['user']);
