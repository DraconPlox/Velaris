import 'dart:io';

import 'package:flutter/material.dart';

import 'import_data_controller.dart';

class ImportDataView extends StatefulWidget {
  ImportDataView({super.key});

  @override
  State<ImportDataView> createState() => _ImportDataViewState();
}

class _ImportDataViewState extends State<ImportDataView> {
  ImportDataController importDataController = ImportDataController();

  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E3657),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
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
                          'tenemos un PDF que explica detalladamente la estructura del json para que funcione la importación sin errores.',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            // Lógica para abrir el enlace
                          },
                          child: const Text(
                            'PDF explicativo sobre JSONs',
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
                            if (file == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'No se ha seleccionado un archivo con la extensión correcta. La extensión tiene que ser .json',
                                  ),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1D1033),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.note_add,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (file != null)
                          Text(
                            file!.path.split(Platform.pathSeparator).last,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed:
                                file == null
                                    ? null
                                    : () async {
                                      if (file != null) {
                                        bool result = await importDataController
                                            .importDreamsFromFile(file!);

                                        if (result) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Se han insertado los datos correctamente',
                                              ),
                                              backgroundColor: Colors.green,

                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Ha habido un error al insertar los datos.',
                                              ),
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      }
                                    },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: Colors.transparent,
                              // Importante para mostrar el gradiente
                              shadowColor: Colors.transparent,
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient:
                                    file == null
                                        ? null
                                        : const LinearGradient(
                                          colors: [
                                            Color(0xFFAE6CFF),
                                            Color(0xFF7F5BFE),
                                          ],
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
          ),
        ],
      ),
    );
  }
}
