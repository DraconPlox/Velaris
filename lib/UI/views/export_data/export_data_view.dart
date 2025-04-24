import 'package:flutter/material.dart';

class ExportDataView extends StatefulWidget {
  const ExportDataView({super.key});

  @override
  State<ExportDataView> createState() => _ExportDataViewState();
}

class _ExportDataViewState extends State<ExportDataView> {
  String selectedFormat = 'json'; // Valores posibles: 'txt' o 'json'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1033),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Exportar datos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D2643),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Actualmente guardamos tus datos en Firebase pero siempre están disponibles para cuando los desees. '
                            'Se exportarán los sueños en tu dispositivo en este formato:',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(height: 30),
                      _buildOption('txt', 'Texto plano (.txt)', Colors.grey.shade400),
                      const SizedBox(height: 16),
                      _buildOption('json', 'Json (.json)', const Color(0xFFDB63FF)),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            // Acción de exportación
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFAE6CFF), Color(0xFF7F5BFE)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Exportar datos',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String value, String label, Color dotColor) {
    final bool isSelected = selectedFormat == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedFormat = value;
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: isSelected ? dotColor : const Color(0xFF1D1033),
              shape: BoxShape.circle,
              border: Border.all(
                color: dotColor,
                width: 2,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}