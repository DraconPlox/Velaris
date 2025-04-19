import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velaris/UI/views/profile/profile_controller.dart';
import 'package:velaris/UI/widgets/user_profile_picture.dart';

import '../../widgets/navbar.dart';
import '../edit_profile/edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final labelsLucidez = ['Lucido', 'No lucido'];
  final coloresLucidez = [Colors.greenAccent, Colors.redAccent];

  ProfileController profileController = ProfileController();
  String? descripcion;
  String? genero;
  DateTime? dob;
  int? year;
  Map<String, int> suenosLucidos = new Map<String, int>();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    suenosLucidos = profileController.getSuenosLucidos(
      await profileController.getDreams(),
    );
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
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed:
                                  () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfileView(),
                                      ),
                                    ),
                                  },
                            ),
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
                          descripcion ?? "",
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
                              genero ?? "",
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
                          child: SizedBox(
                            height: 200,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: PieChart(
                                    PieChartData(
                                      sections: List.generate(labelsLucidez.length, (index) {
                                        final label = labelsLucidez[index]; // Obtenemos la etiqueta
                                        final value = suenosLucidos[label] ?? 0; // Obtenemos el número de sueños de esa etiqueta

                                        return PieChartSectionData(
                                          value: value.toDouble(), // Valor que corresponde a la sección del pastel
                                          color: coloresLucidez[index], // Color correspondiente
                                          title: value > 0 ? '$value' : '', // Solo mostramos el número si es mayor a 0
                                          radius: 60, // Radio del gráfico
                                          titleStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12, // Tamaño del texto del título
                                          ),
                                        );
                                      }),
                                      sectionsSpace: 2, // Espacio entre secciones
                                      centerSpaceRadius: 0, // Espacio en el centro del pastel
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16), // Espacio entre el gráfico y la leyenda
                                // Leyenda a la derecha
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(labelsLucidez.length, (index) {
                                      final label = labelsLucidez[index]; // Obtenemos la etiqueta
                                      final color = coloresLucidez[index]; // Obtenemos el color correspondiente
                                      final count = suenosLucidos[label] ?? 0; // Obtenemos el número de sueños para esa etiqueta

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 12, // Tamaño del círculo de color
                                              height: 12,
                                              decoration: BoxDecoration(
                                                color: color, // Color correspondiente a la etiqueta
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '$label ($count)', // Mostramos la etiqueta y el número de sueños
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12, // Tamaño del texto
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
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
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
