import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import 'package:onpause/features/sign_form/api/login.dart';

Mutation<AuthResponse, Error, LoginRequest> useLoginMutation(
    void Function(AuthResponse, dynamic) onData) {
  return useMutation("login", (variables) => login(variables), onData: onData, onError: (error, a) {
    print(error);
  });
}
