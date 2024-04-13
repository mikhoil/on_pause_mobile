import 'dart:async';

import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import 'package:onpause/features/sign_form/api/login.dart';
import 'package:onpause/features/sign_form/api/register.dart';

Mutation<AuthResponse, Error, RegisterRequest> useRegisterMutation(
    void Function(AuthResponse, dynamic)? onData) {
  return useMutation("register", (variables) => register(variables),
      onData: onData);
}
