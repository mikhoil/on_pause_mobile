import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import '../../settings_screen/api/logout.dart';
import '../../../shared/utils/clear_tokens.dart';
import '../../../shared/utils/refresh_tokens.dart';

Mutation<void, Error, void> useLogout(void Function() redirect) {
  final queryClient = useQueryClient();
  return useMutation('logout', (variables) => withRefreshTokens(logout),
      onError: (error, d) {
    print(error);
  }, onData: (data, other) {
    clearTokens();
    queryClient.cache.clear();
    redirect();
  });
}
