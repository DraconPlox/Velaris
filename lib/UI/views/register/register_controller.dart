import 'package:velaris/service/auth_service.dart';

class RegisterController {
  AuthService authService = AuthService();

  register(String email, String password) {
    authService.registerWithEmail(email, password);
  }
}