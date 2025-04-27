import 'dart:io';

import 'package:flutter/material.dart';

import 'import_data_controller.dart';

class ImportDataView extends StatelessWidget {
  ImportDataView({super.key});
  ImportDataController importDataController = ImportDataController();
  File? file;

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
          'Importar datos',
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
                        'Puedes importar tus sueños de otra app (O de un backup tuyo) desde un archivo con extensión .json. '
                            'Cuidado: Hacer esto restaura todos los sueños que tienes guardados a los del archivo importado '
                            'por lo que si no estás seguro, recomendamos hacer un backup antes desde el apartado de exportar datos.\n\n'
                            'En caso de que no tengas un backup tuyo y quieras pasar tus sueños de otra app a la nuestra, '
                            'tenemos un PDF que explica detalladamente la estructura del json para que funcione la importación sin errores. → ',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Lógica para abrir el enlace
                        },
                        child: const Text(
                          'Enlace',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Importar archivo:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          file = await importDataController.getFile();
                        },
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D1033),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Icon(Icons.note_add, size: 50, color: Colors.white),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: file==null?null: () {
                            print("eeee");
                            if (file != null) {
                              importDataController.importDreamsFromFile(file!);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.transparent, // Importante para mostrar el gradiente
                            shadowColor: Colors.transparent,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: file==null?null: const LinearGradient(
                                colors: [Color(0xFFAE6CFF), Color(0xFF7F5BFE)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Importar datos',
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
}