import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velaris/UI/views/delete_account/delete_account_view.dart';
import 'package:velaris/UI/views/dream_notification_setting/dream_notification_setting_view.dart';
import 'package:velaris/UI/views/edit_email/edit_email_view.dart';
import 'package:velaris/UI/views/edit_password/edit_password_view.dart';
import 'package:velaris/UI/views/export_data/export_data_view.dart';
import 'package:velaris/UI/views/import_data/import_data_view.dart';
import 'package:velaris/UI/views/profile/profile_view.dart';
import 'package:velaris/UI/views/settings/settings_controller.dart';

import '../../../model/entity/dream_user.dart';
import '../../widgets/ajustes_item.dart';
import '../../widgets/navbar.dart';
import '../../widgets/user_profile_picture.dart';

class SettingsView extends StatefulWidget {
  SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsController settingsController = SettingsController();

  DreamUser? dreamUser;
  String? nickname;
  String? email;
  bool? hasProviderGoogle;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await settingsController.initialize();
    dreamUser = settingsController.getUser();
    nickname = dreamUser?.nickname??"";
    email = dreamUser?.email??"";
    hasProviderGoogle = await settingsController.hasProviderGoogle();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E3657),
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
      bottomNavigationBar: Navbar(selectedIndex: 4),
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
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileView()),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UserProfilePicture(url: dreamUser?.profilePicture),
                              const SizedBox(width: 12), // Espacio entre imagen y texto
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 12),
                                    Text(
                                      nickname??"",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      email??"",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Divider(
                          color: Colors.white30,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),
                        if (!(hasProviderGoogle??false)) ...[
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
                        ],
                        AjustesItem(
                          texto: 'Exportar datos',
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExportDataView(),
                                ),
                              ),
                        ),
                        AjustesItem(
                          texto: 'Importar datos',
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImportDataView(),
                                ),
                              ),
                        ),
                        AjustesItem(
                          texto: 'Cambiar ajustes de notificaciones',
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DreamNotificationSettingView(),
                                ),
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
                            leading: const Icon(
                              Icons.warning_amber,
                              color: Colors.redAccent,
                            ),
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
                                MaterialPageRoute(
                                  builder: (context) => DeleteAccountView(),
                                ),
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
          ),
        ],
      ),
    );
  }
}
