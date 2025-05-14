import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/entity/dream.dart';
import '../../../service/firestore_service.dart';

class StatisticsController {
  FirestoreService firestoreService = FirestoreService();

  Future<List<Dream>> getDreams() {
    return firestoreService.getDreams(FirebaseAuth.instance.currentUser!.uid);
  }

  List<BarChartGroupData> getChartDataPorMes(List<Dream> dreams, int year) {
    final Map<String, int> dreamsPerMonth = {};

    for (var dream in dreams) {
      if (dream.date != null && dream.date!.year == year) {
        final key = "${dream.date!.year}-${dream.date!.month.toString().padLeft(2, '0')}";
        dreamsPerMonth[key] = (dreamsPerMonth[key] ?? 0) + 1;
      }
    }

    // Meses de enero a diciembre del año seleccionado
    final List<DateTime> months = List.generate(12, (i) => DateTime(year, i + 1));

    return List.generate(12, (index) {
      final date = months[index];
      final key = "${date.year}-${date.month.toString().padLeft(2, '0')}";
      final count = dreamsPerMonth[key] ?? 0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: count.toDouble(),
            color: Colors.blueAccent,
            width: 12,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  // Para etiquetas en el eje X:
  String getMonthLabel(int index) {
    return DateFormat.MMM('es_ES').format(DateTime(0, index + 1));
  }

  Map<String, int> getDreamsPorTag(List<Dream> dreams) {
    final Map<String, int> tagCounts = {
      'Sin característica': 0,
      'Recurrente': 0,
      'Pesadilla': 0,
      'Parálisis del sueño': 0,
      'Falso despertar': 0,
    };

    for (var dream in dreams) {
      final tag = dream.tag?.toLowerCase().trim();

      if (tag == null || tag.isEmpty) {
        tagCounts['Sin característica'] = tagCounts['Sin característica']! + 1;
      } else if (tag.contains('recurrente')) {
        tagCounts['Recurrente'] = tagCounts['Recurrente']! + 1;
      } else if (tag.contains('pesadilla')) {
        tagCounts['Pesadilla'] = tagCounts['Pesadilla']! + 1;
      } else if (tag.contains('parálisis')) {
        tagCounts['Parálisis del sueño'] = tagCounts['Parálisis del sueño']! + 1;
      } else if (tag.contains('falso despertar')) {
        tagCounts['Falso despertar'] = tagCounts['Falso despertar']! + 1;
      } else {
        tagCounts['Sin característica'] = tagCounts['Sin característica']! + 1;
      }
    }

    return tagCounts;
  }
}
