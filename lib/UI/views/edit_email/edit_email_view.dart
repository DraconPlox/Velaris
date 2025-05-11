import 'package:flutter/material.dart';
import 'package:velaris/UI/views/edit_email/edit_email_controller.dart';

class EditEmailView extends StatefulWidget {
  const EditEmailView({Key? key}) : super(key: key);

  @override
  State<EditEmailView> createState() => _EditEmailViewState();
}

class _EditEmailViewState extends State<EditEmailView> {
  final EditEmailController editEmailController = EditEmailController();
  bool _isLoading = false;
  final TextEditingController currentEmail = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController newEmail = TextEditingController();

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
          'Cambiar correo',
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
                            'Introduce tu correo actual, tu contraseña y el nuevo correo electrónico.',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Contraseña:',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: password,
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
                            'Correo actual:',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: currentEmail,
                            decoration: InputDecoration(
                              hintText: 'Correo actual',
                              filled: true,
                              fillColor: const Color(0xFF1D1033),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: const TextStyle(color: Colors.white38),
                            ),
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Nuevo correo:',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: newEmail,
                            decoration: InputDecoration(
                              hintText: 'Nuevo correo electrónico',
                              filled: true,
                              fillColor: const Color(0xFF1D1033),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: const TextStyle(color: Colors.white38),
                            ),
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 30),
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
                                          ) = await editEmailController
                                              .changeEmail(
                                                currentEmail:
                                                    currentEmail.text.trim(),
                                                password: password.text.trim(),
                                                newEmail: newEmail.text.trim(),
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
                                            currentEmail.clear();
                                            password.clear();
                                            newEmail.clear();
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
                                  'Cambiar correo',
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
