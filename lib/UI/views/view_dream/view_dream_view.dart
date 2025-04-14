import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velaris/UI/views/edit_dream/edit_dream_view.dart';
import 'package:velaris/UI/views/view_dream/view_dream_controller.dart';
import 'package:velaris/model/entity/dream.dart';
import 'package:intl/intl.dart';

class ViewDreamView extends StatefulWidget {
  ViewDreamView({super.key, required this.dreamId});

  final String dreamId;

  @override
  State<ViewDreamView> createState() => _ViewDreamViewState();
}

class _ViewDreamViewState extends State<ViewDreamView> {
  ViewDreamController viewDreamController = ViewDreamController();
  Dream? dream;
  bool loading = true;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    dream = await viewDreamController.getDream(widget.dreamId);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1033),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Ver sueño',
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
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: kToolbarHeight + 24),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.pencil,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => EditDreamView(dreamId: dream?.id??""),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 12),
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.share,
                              color: Colors.white,
                            ),
                            onPressed: () {/*TODO: COMPARTIR SUEÑO*/},
                          ),
                          SizedBox(width: 12),
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.trashCan,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await viewDreamController.deleteDream(dream?.id??"");
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            DateFormat(
                              'd MMM, y',
                              'es_ES',
                            ).format(dream?.fecha ?? DateTime.now()),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          dream?.titulo ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.white30,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dream?.descripcion ?? "",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      const Divider(
                        color: Colors.white30,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Text(
                        'Tags: ${dream?.caracteristica ?? ""}',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'Lúcido:',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Checkbox(
                            value: dream?.lucido ?? false,
                            onChanged: (bool? value) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Calidad de sueño:',
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Icon(
                              index < (dream?.calidad ?? 0)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 32,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Horario de sueño: ${dream?.horaInicio?.hour ?? DateTime(0).hour}:${dream?.horaInicio?.minute ?? DateTime(0).minute} - ${dream?.horaFinal?.hour ?? DateTime(0).hour}:${dream?.horaFinal?.minute ?? DateTime(0).minute}',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
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
    );
  }
}
