import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_view.dart';
import 'package:velaris/UI/views/statistics/statistics_view.dart';
import 'package:velaris/UI/views/profile/profile_view.dart';
import 'package:velaris/UI/views/search_user/search_user_view.dart';
import 'package:velaris/UI/views/settings/settings_view.dart';
import 'package:velaris/UI/views/view_friends/view_friends_view.dart';
import 'package:velaris/UI/widgets/user_profile_picture.dart';
import 'package:velaris/model/entity/dream_user.dart';
import 'package:velaris/service/firestore_service.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  DreamUser? user;
  FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    user = await firestoreService.getDreamUser(
      FirebaseAuth.instance.currentUser?.uid ?? "",
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 75,
        color: const Color(0xFF3E3657),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CalendarDreamsView(),
                              ),
                              (Route<dynamic> route) =>
                                  false, // esto elimina todas las rutas anteriores
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StatisticsView(),
                              ),
                              (Route<dynamic> route) =>
                                  false, // esto elimina todas las rutas anteriores
                            );
                          },
                        ),
                        const Text(
                          "Estadísticas",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
      
                    //const SizedBox(width: 70), // Espacio para el avatar
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.user, color: Colors.white70),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewFriendsView(),
                              ),
                              (Route<dynamic> route) =>
                                  false, // esto elimina todas las rutas anteriores
                            );
                          },
                        ),
                        const Text(
                          "Lista amigos",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
      
                    // Buscar
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.white70),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchUserView(),
                              ),
                              (Route<dynamic> route) =>
                                  false, // esto elimina todas las rutas anteriores
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsView(),
                              ),
                              (Route<dynamic> route) =>
                                  false, // esto elimina todas las rutas anteriores
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
            /*
            Positioned(
              top: -45,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileView()),
                          (Route<dynamic> route) => false, // esto elimina todas las rutas anteriores
                    );
                  },
                  child: Container(
                    width: 75,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF3E3657),
                    ),
                    child: UserProfilePicture(url: user?.profilePicture),
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
