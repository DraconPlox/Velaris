import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/my_calendar_widget.dart';

class CalendarDreamsView extends StatefulWidget {
  CalendarDreamsView({super.key});

  @override
  State<CalendarDreamsView> createState() => _CalendarDreamsViewState();
}

class _CalendarDreamsViewState extends State<CalendarDreamsView> {
  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1033),
      extendBodyBehindAppBar: true,
      // Para que la imagen cubra detrás del AppBar
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
              child: const Icon(Icons.add, color: Colors.white),
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
              'assets/images/background.png', // Cambia por tu ruta
              fit: BoxFit.cover,
            ),
          ),

          // Contenido principal
          Column(
            children: [
              const SizedBox(height: kToolbarHeight + 24),
              // Espacio para AppBar
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D2643),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      MyCalendarWidget()
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
        color: const Color(0xFF322548),
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
