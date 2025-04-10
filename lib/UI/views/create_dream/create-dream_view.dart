import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CreateDreamView(),
  ));
}

class CreateDreamView extends StatelessWidget {
  const CreateDreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1432),
      appBar: AppBar(
        backgroundColor: Color(0xFF1D1432),
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Text('Crear sueño', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white70, size: 18),
                SizedBox(width: 8),
                Text('02 Abr, 2025', style: TextStyle(color: Colors.white70)),
              ],
            ),
            SizedBox(height: 20),
            Text('Titulo', style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF2A1E4C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Maecenas imperdiet fermentum augue vel accumsan. Vestibulum tempus pulvinar risus '
                    'sit amet malesuada...',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(height: 20),
            Text('Horario de sueño:', style: TextStyle(color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTimeBox("00", "30"),
                Text('-', style: TextStyle(color: Colors.white, fontSize: 24)),
                buildTimeBox("07", "00"),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildIconBox(FontAwesomeIcons.rotateLeft, 'Recurrente'),
                buildIconBox(FontAwesomeIcons.ghost, 'Pesadilla'),
                buildIconBox(FontAwesomeIcons.headSideCough, 'Parálisis del sueño'),
                buildIconBox(FontAwesomeIcons.clock, 'Falso despertar'),
              ],
            ),
            SizedBox(height: 20),
            Text('Calidad de sueño:', style: TextStyle(color: Colors.white)),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < 2 ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('¿Ha sido lúcido?', style: TextStyle(color: Colors.white)),
                Spacer(),
                Checkbox(
                  value: true,
                  onChanged: (_) {},
                  activeColor: Colors.purpleAccent,
                )
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB45CFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('Añadir', style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTimeBox(String hour, String minute) {
    return Row(
      children: [
        timeBox(hour),
        SizedBox(width: 4),
        Text(':', style: TextStyle(color: Colors.white, fontSize: 18)),
        SizedBox(width: 4),
        timeBox(minute),
      ],
    );
  }

  Widget timeBox(String text) {
    return Container(
      width: 48,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFF2A1E4C),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }

  Widget buildIconBox(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Color(0xFF2A1E4C),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 4),
        Text(label,
            style: TextStyle(color: Colors.white70, fontSize: 10),
            textAlign: TextAlign.center),
      ],
    );
  }
}
