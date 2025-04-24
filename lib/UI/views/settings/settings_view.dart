import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velaris/UI/views/delete_account/delete_account_view.dart';
import 'package:velaris/UI/views/dream_notification_setting/dream_notification_setting_view.dart';
import 'package:velaris/UI/views/edit_email/edit_email_view.dart';
import 'package:velaris/UI/views/edit_password/edit_password_view.dart';
import 'package:velaris/UI/views/export_data/export_data_view.dart';
import 'package:velaris/UI/views/import_data/import_data_view.dart';
import 'package:velaris/UI/views/settings/settings_controller.dart';

import '../../widgets/ajustes_item.dart';
import '../../widgets/navbar.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final SettingsController settingsController = SettingsController();

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
                          MaterialPageRoute(builder: (context) => EditPasswordView()),
                        ),
                      ),
                      AjustesItem(
                        texto: 'Cambiar correo',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditEmailView()),
                        ),
                      ),
                      AjustesItem(
                        texto: 'Exportar datos',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ExportDataView()),
                        ),
                      ),
                      AjustesItem(
                        texto: 'Importar datos',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ImportDataView()),
                        ),
                      ),
                      AjustesItem(
                        texto: 'Cambiar ajustes de notificaciones',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DreamNotificationSettingView()),
                        ),
                      ),
                      AjustesItem(
                        texto: 'Cerrar sesión',
                        onTap: () => settingsController.cerrarSesion(context),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.warning_amber, color: Colors.redAccent),
                          title: const Text(
                            'Borrar cuenta',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DeleteAccountView()),
                            );
                          },
                        ),
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