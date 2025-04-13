import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewDreamView extends StatelessWidget {
  ViewDreamView({super.key});

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
      body: Stack(children: [
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
                  padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(FontAwesomeIcons.pencil, color: Colors.white),
                        SizedBox(width: 12),
                        Icon(Icons.share, color: Colors.white),
                        SizedBox(width: 12),
                        Icon(FontAwesomeIcons.trashCan, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.calendar_today, size: 20, color: Colors.white),
                        SizedBox(width: 8),
                        Text('13 Abr, 2025', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: const Text(
                        'Título',
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
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                          'Maecenas imperdiet fermentum augue vel accumsan. Vestibulum tempus pulvinar risus sit amet malesuada. '
                          'Donec iaculis odio dolor, eu varius est facilisis sit amet. Donec sit amet arcu eget sem vehicula auctor quis non sem. '
                          'Aliquam quis lectus semper, efficitur elit sit amet, accumsan enim. Integer ornare ut est at condimentum. '
                          'Pellentesque eget odio sit amet eros fermentum venenatis. Phasellus nec lacus blandit, euismod orci vitae, pharetra est.\n\n'
                          'Nam scelerisque turpis in magna placerat pellentesque. Vestibulum tincidunt tempus lacus nec laoreet.',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: Colors.white30,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    const Text(
                      'Tags: Recurrente.',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Text('Lúcido:', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 8),
                        Icon(Icons.check_box, color: Colors.white),
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
                          onTap: () {
                            // onTap deshabilitado
                          },
                          child: Icon(
                            index < 2 ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 32,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Horario de sueño: 00:30 - 07:00',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
