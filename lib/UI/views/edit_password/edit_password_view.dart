import 'package:flutter/material.dart';
import 'package:velaris/UI/views/edit_password/edit_password_controller.dart';

class EditPasswordView extends StatefulWidget {
  const EditPasswordView({Key? key}) : super(key: key);

  @override
  State<EditPasswordView> createState() => _EditPasswordViewState();
}

class _EditPasswordViewState extends State<EditPasswordView> {
  EditPasswordController editPasswordController = EditPasswordController();
  bool _isLoading = false;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController repeatNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2643),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cambiar contraseña',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            bottom: 400,
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D2643),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            'Introduzca tu actual contraseña y la nueva.',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Contraseña actual:',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: oldPassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Contraseña actual',
                              filled: true,
                              fillColor: const Color(0xFF1D1033),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: const TextStyle(color: Colors.white38),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Nueva contraseña:',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: newPassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Nueva contraseña',
                              filled: true,
                              fillColor: const Color(0xFF1D1033),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: const TextStyle(color: Colors.white38),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Repetir contraseña:',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: repeatNewPassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Repetir contraseña',
                              filled: true,
                              fillColor: const Color(0xFF1D1033),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: const TextStyle(color: Colors.white38),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFDA44BB), Color(0xFF8921AA)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed:
                                    _isLoading
                                        ? null
                                        : () async {
                                          setState(() => _isLoading = true);

                                          final (
                                            success,
                                            message,
                                          ) = await editPasswordController.changePassword(
                                            oldPassword: oldPassword.text.trim(),
                                            newPassword: newPassword.text.trim(),
                                            repeatPassword:
                                                repeatNewPassword.text.trim(),
                                          );

                                          if (!mounted) return;

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(message),
                                              backgroundColor:
                                                  success
                                                      ? Colors.green
                                                      : Colors.redAccent,
                                            ),
                                          );

                                          setState(() => _isLoading = false);

                                          if (success) {
                                            oldPassword.clear();
                                            newPassword.clear();
                                            repeatNewPassword.clear();
                                          }
                                        },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: const Text(
                                  'Cambiar contraseña',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
