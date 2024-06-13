import '../../../shared/api/models/auth_response.dart';
import '../../../shared/api/instances/auth_instance.dart';
import '../../../shared/api/models/register_request.dart';

Future<AuthResponse> register(RegisterRequest body) async =>
    AuthResponse.fromJson(
        (await authInstance.post('/register', data: body.toJson())).data);
