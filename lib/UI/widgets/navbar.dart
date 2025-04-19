import 'package:flutter/material.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_view.dart';
import 'package:velaris/UI/views/estadisticas/estadisticas_view.dart';
import 'package:velaris/UI/views/profile/profile_view.dart';
import 'package:velaris/UI/views/search_user/search_user_view.dart';
import 'package:velaris/UI/views/settings/settings_view.dart';
import 'package:velaris/UI/widgets/user_profile_picture.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: const Color(0xFF3E3657),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Fila de iconos
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Sueños
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.bedtime, color: Colors.white70),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CalendarDreamsView(),
                            ),
                          );
                        },
                      ),
                      const Text(
                        "Sueños",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),

                  // Estadísticas
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.bar_chart,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EstadisticasView(),
                            ),
                          );
                        },
                      ),
                      const Text(
                        "Estadísticas",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),

                  const SizedBox(width: 70), // Espacio para el avatar
                  // Buscar
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white70),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchUserView(),
                            ),
                          );
                        },
                      ),
                      const Text(
                        "Buscar",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),

                  // Ajustes
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white70),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsView(),
                            ),
                          );
                        },
                      ),
                      const Text(
                        "Ajustes",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Avatar en el centro, sobresaliente
          Positioned(
            top: -45,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileView()),
                  );
                },
                child: Container(
                  width: 75,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF3E3657),
                  ),
                  child: UserProfilePicture(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
