import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import '../api/manage_subscription.dart';
import '../../../shared/utils/refresh_tokens.dart';
import '../../home_screen/api/fetch_user.dart';

final queryClient = useQueryClient();

Mutation<User, Error, void> useSubscriptionOn() => useMutation(
    "subscription on", (variables) => withRefreshTokens(subscriptionOn),
    refreshQueries: ['user', 'practices']);
