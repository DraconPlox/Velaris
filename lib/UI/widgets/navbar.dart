import 'package:flutter/material.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_view.dart';
import 'package:velaris/UI/views/profile/profile_view.dart';
import 'package:velaris/UI/views/search_user/search_user_view.dart';
import 'package:velaris/UI/views/settings/settings_view.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF322548),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.bedtime, color: Colors.white70),
              onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CalendarDreamsView()));}
            ),
            const Icon(Icons.bar_chart, color: Colors.white70),

            // CircleAvatar clickeable
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileView()),
                );
              },
              child: const CircleAvatar(
                backgroundColor: Colors.deepPurple,
                backgroundImage: AssetImage('assets/images/google.png'),
                radius: 24,
              ),
            ),

            IconButton(
              icon: Icon(Icons.search, color: Colors.white70),
              onPressed: () {Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SearchUserView()),
              );},
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white70),
              onPressed: () {Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SettingsView()),
              );},
            ),
          ],
        ),
      ),
    );
  }
}
