import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velaris/UI/views/edit_email/edit_email_view.dart';
import 'package:velaris/UI/views/edit_password/edit_password_view.dart';
import 'package:velaris/UI/views/settings/settings_controller.dart';

import '../../widgets/ajustes_item.dart';
import '../../widgets/navbar.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1033),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Ajustes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: kToolbarHeight + 24),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D2643),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      AjustesItem(
                        texto: 'Cambiar contraseña',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPasswordView(),
                          ),
                        ),
                      ),
                      AjustesItem(
                        texto: 'Cambiar correo',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditEmailView(),
                          ),
                        ),
                      ),
                      const AjustesItem(texto: 'Exportar datos'),
                      const AjustesItem(texto: 'Importar datos'),
                      const AjustesItem(texto: 'Cambiar ajustes de notificaciones'),
                      AjustesItem(
                        texto: 'Cerrar sesión',
                        onTap: () => settingsController.cerrarSesion(context),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Borrar cuenta',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
