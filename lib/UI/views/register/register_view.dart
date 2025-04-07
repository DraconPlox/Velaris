import 'package:flutter/material.dart';
import 'package:velaris/UI/views/register/register_controller.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RegisterController registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF190B2C),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2544),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Registrate',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Inserta tus datos:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Correo:",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: email,
                decoration: InputDecoration(
                  hintText: "Correo",
                  hintStyle: TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Color(0xFF1E1A2E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              const SizedBox(height: 12),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nombre de usuario:",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: password,
                decoration: InputDecoration(
                  hintText: "Nombre de usuario",
                  hintStyle: TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Color(0xFF1E1A2E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              const SizedBox(height: 12),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contraseña:",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 4),
              const TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Contraseña",
                  hintStyle: TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Color(0xFF1E1A2E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              const SizedBox(height: 12),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Repetir contraseña:",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 4),
              const TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Repetir contraseña",
                  hintStyle: TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Color(0xFF1E1A2E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEA6DE7), Color(0xFF7A5FFF)],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {registerController.register(email.text, password.text);},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}