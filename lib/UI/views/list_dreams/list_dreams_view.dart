import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_view.dart';
import 'package:velaris/UI/views/create_dream/create-dream_view.dart';

import '../../../model/entity/dream.dart';
import '../../widgets/navbar.dart';
import '../view_dream/view_dream_view.dart';
import 'list_dreams_controller.dart';

class ListDreamsView extends StatefulWidget {
  const ListDreamsView({super.key});

  @override
  State<ListDreamsView> createState() => _ListDreamsViewState();
}

class _ListDreamsViewState extends State<ListDreamsView> {
  ListDreamsController listDreamsController = ListDreamsController();
  List<Dream> listaDreams = [];
  bool loading = true;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    listaDreams = await listDreamsController.getDreams();
    loading = false;
    setState(() {});
  }

  Map<DateTime, List<Dream>> groupDreamsByDate(List<Dream> dreams) {
    // Ordenar de más reciente a más antiguo
    dreams.sort((a, b) => b.fecha!.compareTo(a.fecha!));

    final Map<DateTime, List<Dream>> grouped = {};

    for (var dream in dreams) {
      final date = DateTime(
        dream.fecha!.year,
        dream.fecha!.month,
        dream.fecha!.day,
      );
      grouped.putIfAbsent(date, () => []).add(dream);
    }

    return grouped;
  }

  Widget DreamCard({
    required String id,
    required String titulo,
    required String descripcion,
    required bool lucido,
  }) {
    return InkWell(
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => ViewDreamView(dreamId: id),
          ),
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
    Map<DateTime, List<Dream>> mapDreams = groupDreamsByDate(listaDreams);

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
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 16,
                      right: 16,
                    ),
                    children: [
                      // Botón calendario arriba sin fondo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 20,
                            ),
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
                      for (int i = 0; i < mapDreams.length; i++) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 8),
                          child: Center(
                            child: Text(
                              DateFormat("d MMM, yyyy", 'es_ES').format(mapDreams.keys.toList()[i]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.5,
                                letterSpacing: 1,

                              ),
                            ),
                          ),
                        ),
                        for (int j = 0; j < mapDreams.values.toList()[i].length; j++ )
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 16),
                            child: DreamCard(
                            id: mapDreams.values.toList()[i][j].id??"",
                            titulo: mapDreams.values.toList()[i][j].titulo??"",
                            descripcion: mapDreams.values.toList()[i][j].descripcion??"",
                            lucido: mapDreams.values.toList()[i][j].lucido??false,
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (loading)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withAlpha(150),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),

      // BottomNavigationBar
      bottomNavigationBar: Navbar(),
    );
  }
}
