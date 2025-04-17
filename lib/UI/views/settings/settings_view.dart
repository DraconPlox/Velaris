import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/navbar.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
                    children: const [
                      AjustesItem(texto: 'Cambiar contraseña'),
                      AjustesItem(texto: 'Cambiar correo'),
                      AjustesItem(texto: 'Exportar datos'),
                      AjustesItem(texto: 'Importar datos'),
                      AjustesItem(texto: 'Cambiar ajustes de notificaciones'),
                      AjustesItem(texto: 'Cerrar sesión'),
                      SizedBox(height: 10),
                      Text(
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

class AjustesItem extends StatelessWidget {
  final String texto;
  const AjustesItem({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        texto,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {},
    );
  }
}
