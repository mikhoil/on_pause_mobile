import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import '../../../shared/api/models/auth_response.dart';
import '../../../shared/api/models/login_request.dart';
import '../api/login.dart';

Mutation<AuthResponse, Error, LoginRequest> useLoginMutation(
        void Function(AuthResponse, dynamic) onData) =>
    useMutation("login", (variables) => login(variables), onData: onData);
