import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velaris/UI/views/lista_sue%C3%B1os/list_dreams_view.dart';
import 'package:velaris/UI/views/register/register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF190B2C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 80),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF2D2642),
              borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '¡Bienvenido!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Inicia sesión:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Correo:',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Correo',
                      filled: true,
                      fillColor: Color(0xFF1E1B2E),
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Contraseña:',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      filled: true,
                      fillColor: Color(0xFF1E1B2E),
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFB84DFF), Color(0xFF5D5FEF)],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ListDreamsView()));},
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Iniciar con Google',
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: Image.asset("assets/images/google.png")
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '¿No tienes cuenta?\n¡Regístrate!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFB84DFF), Color(0xFF5D5FEF)],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView()));},
                      child: Text(
                        'Registrarse',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
