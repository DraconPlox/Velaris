import 'package:firebase_auth/firebase_auth.dart';

class EditEmailController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<(bool success, String message)> changeEmail({
    required String currentEmail,
    required String password,
    required String newEmail,
  }) async {
    final user = _auth.currentUser;

    if (user == null) return (false, 'Usuario no autenticado');

    if (currentEmail.isEmpty || password.isEmpty || newEmail.isEmpty) {
      return (false, 'Rellena todos los campos');
    }

    if (!isValidEmail(newEmail)) {
      return (false, 'El nuevo correo no tiene un formato válido');
    }

    // Comprobamos si el email introducido coincide con el actual
    if (user.email != currentEmail) {
      return (false, 'El correo actual no coincide con el del usuario');
    }

    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    try {
      await user.reauthenticateWithCredential(cred);
      await user.verifyBeforeUpdateEmail(newEmail);
      return (true, 'Verifica tu nuevo correo para completar el cambio');
    } catch (e) {
      return (false, 'Error al cambiar el correo: ${e.toString()}');
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

}