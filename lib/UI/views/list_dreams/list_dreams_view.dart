import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_view.dart';
import 'package:velaris/UI/views/create_dream/create-dream_view.dart';

class ListDreamsView extends StatelessWidget {
  const ListDreamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1033),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Diario de sueños',
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
              padding: const EdgeInsets.all(8),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateDreamView()));
                },
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

              // Zona violeta con la lista scrolleable
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D2643),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                    children: [
                      // Botón calendario arriba sin fondo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.calendar_today, color: Colors.white, size: 20),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CalendarDreamsView(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Aquí irán las tarjetas de sueños
                      // DreamCard(title: "Sueño #1", description: "Descripción...")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // BottomNavigationBar
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF3E3657),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.bedtime, color: Colors.white70),
              Icon(Icons.bar_chart, color: Colors.white70),
              CircleAvatar(
                backgroundColor: Colors.deepPurple,
                backgroundImage: AssetImage('assets/images/google.png'),
                radius: 24,
              ),
              Icon(Icons.search, color: Colors.white70),
              Icon(Icons.settings, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}
