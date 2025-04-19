import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:velaris/UI/views/estadisticas/estadisticas_controller.dart';
import 'package:velaris/UI/widgets/navbar.dart';

import '../../../model/entity/dream.dart'; // Reemplaza con tu navbar si es personalizado

class EstadisticasView extends StatefulWidget {
  EstadisticasView({super.key});

  @override
  State<EstadisticasView> createState() => _EstadisticasViewState();
}

class _EstadisticasViewState extends State<EstadisticasView> {
  EstadisticasController estadisticasController = EstadisticasController();
  List<Dream> listaDreams = [];
  int selectedYear = DateTime.now().year;
  Map<String, int> tagCounts = new Map<String, int>();

  final tagLabels = [
    'Sin caracteristica',
    'Recurrente',
    'Pesadilla',
    'Parálisis del sueño',
    'Falso despertar',
  ];

  final tagColors = [
    const Color(0xFF20D6C1), // Sin caracteristica
    const Color(0xFFFFD166), // Recurrente
    const Color(0xFFEF476F), // Pesadilla
    Colors.purpleAccent, // Parálisis del sueño
    Colors.blueAccent, // Falso despertar
  ];

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future initialize() async {
    listaDreams = await estadisticasController.getDreams();
    tagCounts = estadisticasController.getDreamsPorTag(listaDreams);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1033),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Tus estadísticas',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Navbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2D2643),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Text(
                'Horas de sueño',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          selectedYear--;
                        });
                      },
                    ),
                    Text(
                      "$selectedYear",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          selectedYear++;
                        });
                      },
                    ),
                  ],
                ),
              ),

              //Gráfico de barras
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              rod.toY.toInt().toString(),
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  estadisticasController.getMonthLabel(
                                    value.toInt(),
                                  ),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text(
                                value.toInt().toString(),
                                style: TextStyle(color: Colors.white),
                              );
                            },
                            interval: 1,
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: estadisticasController.getChartDataPorMes(
                        listaDreams,
                        selectedYear,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
              const Text(
                'Numero de sueños por tag',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Gráfico circular
              Row(
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: PieChart(
                      PieChartData(
                        sections: List.generate(tagLabels.length, (index) {
                          final label = tagLabels[index];
                          final value = tagCounts[label] ?? 0;

                          return PieChartSectionData(
                            value: value.toDouble(),
                            color: tagColors[index],
                            title: value > 0 ? '$value' : '',
                            radius: 60,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        }),
                        sectionsSpace: 2,
                        centerSpaceRadius: 0,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(tagLabels.length, (index) {
                      final label = tagLabels[index];
                      final color = tagColors[index];
                      final count = tagCounts[label] ?? 0;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              "$label ($count)",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
