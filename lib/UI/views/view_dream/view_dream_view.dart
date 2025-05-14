import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velaris/UI/views/edit_dream/edit_dream_view.dart';
import 'package:velaris/UI/views/view_dream/view_dream_controller.dart';
import 'package:velaris/model/entity/dream.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

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

  String _formatTime(int? time) {
    return time?.toString().padLeft(2, '0') ?? '00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2643),
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
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            bottom: 400,
          ),
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
                                        (context) => EditDreamView(
                                          dreamId: dream?.id ?? "",
                                        ),
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
                              onPressed: () {
                                Share.share(
                                  'Título: ${dream?.title ?? ""}\n\nDescripción: ${dream?.description ?? ""}\n\nLucido: ${dream?.lucid}',
                                );
                              },
                            ),
                            SizedBox(width: 12),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.trashCan,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return Center(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          width: 300,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF433865),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                '¿Estás seguro que deseas eliminar este sueño?',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: const Text(
                                                      'Cancelar',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      await viewDreamController.deleteDream(dream?.id??"");
                                                      Navigator.pop(ctx);
                                                      Navigator.pop(context);
                                                    },
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                    child: const Text(
                                                      'Eliminar',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
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
                              ).format(dream?.date ?? DateTime.now()),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            dream?.title ?? "",
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
                          dream?.description ?? "",
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
                          'Tags: ${dream?.tag ?? ""}',
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
                              value: dream?.lucid ?? false,
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
                                index < (dream?.rating ?? 0)
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
                          'Horario de sueño: ${_formatTime(dream?.dreamStart?.hour)}:${_formatTime(dream?.dreamStart?.minute)} - ${_formatTime(dream?.dreamEnd?.hour)}:${_formatTime(dream?.dreamEnd?.minute)}',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 20),
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
        ],
      ),
    );
  }
}
