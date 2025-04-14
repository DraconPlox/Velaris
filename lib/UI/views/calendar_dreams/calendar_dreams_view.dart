import 'package:flutter/material.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_controller.dart';
import 'package:velaris/UI/views/create_dream/create-dream_view.dart';

import '../../../model/entity/dream.dart';
import '../../widgets/my_calendar_widget.dart';
import '../view_dream/view_dream_view.dart';

class CalendarDreamsView extends StatefulWidget {
  CalendarDreamsView({super.key});

  @override
  State<CalendarDreamsView> createState() => _CalendarDreamsViewState();
}

class _CalendarDreamsViewState extends State<CalendarDreamsView> {
  CalendarDreamsController calendarDreamsController =
      CalendarDreamsController();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<Dream> allDreams = []; // Todos los sueños
  List<Dream> selectedDreams = []; // Sueños del día seleccionado

  @override
  void initState() {
    super.initState();
    loadDreams();
    filterDreamsByDate(_selectedDay);
  }

  void loadDreams() async {
    allDreams = await calendarDreamsController.getDreams();
    filterDreamsByDate(DateTime.now());
  }

  void filterDreamsByDate(DateTime date) {
    setState(() {
      _selectedDay = date;
      selectedDreams =
          allDreams.where((dream) {
            return dream.fecha != null &&
                dream.fecha!.year == date.year &&
                dream.fecha!.month == date.month &&
                dream.fecha!.day == date.day;
          }).toList();
    });
  }

  Widget DreamCard({
    required String id,
    required String titulo,
    required String descripcion,
    required bool lucido,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewDreamView(dreamId: id)),
        );
      },
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF40396E), // Fondo morado oscuro
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              descripcion,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

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
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateDreamView()),
                  );
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
                      MyCalendarWidget(
                        onDaySelected: (DateTime date) {
                          setState(() {
                            _selectedDay = date;
                            filterDreamsByDate(_selectedDay);
                          });
                        },
                      ),
                      for (int i = 0; i < selectedDreams.length; i++)
                        DreamCard(
                          id: selectedDreams[i].id ?? "",
                          titulo: selectedDreams[i].titulo ?? "",
                          descripcion: selectedDreams[i].descripcion ?? "",
                          lucido: selectedDreams[i].lucido ?? false,
                        ),
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
