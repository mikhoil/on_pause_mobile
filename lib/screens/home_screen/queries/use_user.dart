import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import '../../../shared/utils/refresh_tokens.dart';

import '../api/fetch_user.dart';

Query<User, Error> useUser() {
  print('fetching user');
  return useQuery("user", () => withRefreshTokens(fetchUser), onError: (error) {
    print("error $error");
  }, onData: (data) {
    print("user $data");
  },
      refreshConfig: RefreshConfig(
          refreshInterval: Duration(hours: 1),
          staleDuration: Duration(hours: 1),
          refreshOnMount: false,
          refreshOnQueryFnChange: false,
          refreshOnNetworkStateChange: false)
  );
}
