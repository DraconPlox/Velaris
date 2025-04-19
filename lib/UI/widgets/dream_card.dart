import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/view_dream/view_dream_view.dart';

class DreamCard extends StatelessWidget {
  const DreamCard({
    super.key,
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.lucido,
  });

  final String id;
  final String titulo;
  final String descripcion;
  final bool lucido;

  @override
  Widget build(BuildContext context) {
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
}
