import '../../../shared/api/instances/auth_instance.dart';
import '../../../shared/api/models/auth_response.dart';
import '../../../shared/api/models/login_request.dart';

Future<AuthResponse> login(LoginRequest body) async => AuthResponse.fromJson(
    (await authInstance.post("/login", data: body.toJson())).data
        as Map<String, dynamic>);
