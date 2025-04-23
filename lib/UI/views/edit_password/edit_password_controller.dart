import 'package:firebase_auth/firebase_auth.dart';

class EditPasswordController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<(bool success, String message)> changePassword({
    required String oldPassword,
    required String newPassword,
    required String repeatPassword,
  }) async {
    final user = _auth.currentUser;

    if (user == null) return (false, 'Usuario no autenticado');

    if (oldPassword.isEmpty || newPassword.isEmpty || repeatPassword.isEmpty) {
      return (false, 'Rellena todos los campos');
    }

    if (newPassword != repeatPassword) {
      return (false, 'Las nuevas contraseñas no coinciden');
    }

    if (newPassword.length < 6) {
      return (false, 'La nueva contraseña debe tener al menos 6 caracteres');
    }

    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: oldPassword,
    );

    try {
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
      return (true, 'Contraseña cambiada');
    } catch (e) {
      return (false, 'La contraseña actual es incorrecta');
    }
  }
}
