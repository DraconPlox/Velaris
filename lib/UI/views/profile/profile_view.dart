import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velaris/UI/views/profile/profile_controller.dart';
import 'package:velaris/UI/widgets/user_profile_picture.dart';

import '../../widgets/navbar.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileController profileController = ProfileController();
  String? descripcion;
  String? genero;
  DateTime? dob;
  int? year;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    descripcion = await profileController.getDescription();
    genero = await profileController.getGender();
    dob = await profileController.getDob();
    if (dob != null) {
      // Fecha actual
      DateTime currentDate = DateTime.now();

      // Calcular la diferencia entre las fechas
      Duration difference = currentDate.difference(dob!);

      // Obtener años, meses y días
      year = (difference.inDays / 365).floor();
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1033),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Perfil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // Contenido principal
          Column(
            children: [
              const SizedBox(height: kToolbarHeight + 24),

              // Zona violeta
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D2643),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Iconos superiores alineados a la derecha
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.edit, color: Colors.white),
                            SizedBox(width: 8),
                            Icon(FontAwesomeIcons.user, color: Colors.white),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Avatar y nombre alineados a la izquierda
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            UserProfilePicture(),
                            SizedBox(width: 16),
                            Text(
                              'DraconPlox',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Descripción
                        Text(
                          descripcion??"",
                          style: const TextStyle(color: Colors.white70),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),

                        // Fecha de nacimiento y género
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Fecha de Nacimiento: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              dob != null && year != null
                                  ? '${dob!.day.toString().padLeft(2, '0')}/${dob!.month.toString().padLeft(2, '0')}/${dob!.year} ($year años)'
                                  : 'Cargando...',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Género: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              genero??"",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Título sección gráfica
                        const Text(
                          'Sueños en total',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Zona de la gráfica (placeholder)
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3E3657),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Text(
                              'Gráfica aquí',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Leyenda de la gráfica
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• Total: 300',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '• Normales: 250',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '• Lúcidos: 50',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
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
