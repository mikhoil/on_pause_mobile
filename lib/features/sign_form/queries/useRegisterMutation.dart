import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';

import '../../../shared/api/models/auth_response.dart';
import '../../../shared/api/models/register_request.dart';
import '../api/register.dart';

Mutation<AuthResponse, Error, RegisterRequest> useRegisterMutation(
    void Function(AuthResponse, dynamic)? onData) {
  return useMutation("register", (variables) => register(variables),
      onData: onData);
}
