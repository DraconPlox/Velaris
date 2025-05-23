import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_view.dart';
import 'package:velaris/UI/views/create_dream/create-dream_view.dart';

import '../../../model/entity/dream.dart';
import '../../widgets/dream_card.dart';
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
  StreamSubscription<List<Dream>>? dreamSubscription;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    //listaDreams = await listDreamsController.getDreams();
    dreamSubscription = listDreamsController.listenerDreams().listen((
      List<Dream> dreams,
    ) {
      loading = true;
      listaDreams = dreams;
      setState(() {});
      loading = false;
    });
  }

  @override
  void dispose() {
    dreamSubscription?.cancel();
    super.dispose();
  }

  Map<DateTime, List<Dream>> groupDreamsByDate(List<Dream> dreams) {
    // Ordenar de más reciente a más antiguo
    dreams.sort((a, b) => b.date!.compareTo(a.date!));

    final Map<DateTime, List<Dream>> grouped = {};

    for (var dream in dreams) {
      final date = DateTime(
        dream.date!.year,
        dream.date!.month,
        dream.date!.day,
      );
      grouped.putIfAbsent(date, () => []).add(dream);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<Dream>> mapDreams = groupDreamsByDate(listaDreams);

    return Scaffold(
      backgroundColor: const Color(0xFF3E3657),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Diario de sueños',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: Navbar(selectedIndex: 0),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            bottom: 400,
          ),
          // Contenido principal
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

                        if (mapDreams.isNotEmpty) ...[
                          // Aqui iran las tarjetas de sueños
                          for (int i = 0; i < mapDreams.length; i++) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8, top: 8),
                              child: Center(
                                child: Text(
                                  DateFormat(
                                    "d MMM, yyyy",
                                    'es_ES',
                                  ).format(mapDreams.keys.toList()[i]),
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
                            for (
                              int j = 0;
                              j < mapDreams.values.toList()[i].length;
                              j++
                            )
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 16,
                                ),
                                child: DreamCard(
                                  id: mapDreams.values.toList()[i][j].id ?? "",
                                  titulo:
                                      mapDreams.values.toList()[i][j].title ?? "",
                                  descripcion:
                                      mapDreams.values
                                          .toList()[i][j]
                                          .description ??
                                      "",
                                  lucido:
                                      mapDreams.values.toList()[i][j].lucid ??
                                      false,
                                ),
                              ),
                          ],
                        ] else ...[
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                "Aún no hay sueños guardados. ¡Crea uno nuevo para empezar!",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (loading)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withAlpha(150),
              child: Center(child: CircularProgressIndicator()),
            ),
          // Boton flotante en la esquina inferior derecha
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(8),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
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
    );
  }
}
