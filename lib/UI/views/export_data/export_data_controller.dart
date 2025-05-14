import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../../../model/entity/dream.dart';
import '../../../service/firestore_service.dart';

class ExportDataController {
  final firestoreService = FirestoreService();

  Future<Directory?> getDirectory() async {
    Directory? directory;
    if (Platform.isAndroid) {
      await Permission.storage.request();
      directory = (await getExternalStorageDirectories(type: StorageDirectory.downloads))?.first;
      if (await Permission.storage.isGranted) {

      } else {
        //throw Exception('No se concedió el permiso de almacenamiento.');
      }
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    return directory;
  }

  String formatDateTime(DateTime? dateTime) {
    return dateTime != null ? DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime) : 'Sin fecha';
  }

  Future<bool> exportDreams(String format) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<Dream> dreams = await firestoreService.getDreams(userId);
    File? file;

    if (dreams.isEmpty) {
      print('No hay sueños para exportar.');
      return false; // Retorna false si no hay sueños para exportar
    }

    String content = "";

    if (format == 'json') {
      // Convertir las fechas en formato adecuado antes de convertir el objeto Dream a JSON
      List<Map<String, dynamic>> dreamsJson = dreams.map((dream) {
        // Utilizamos el toJson() para convertir el objeto Dream en un mapa
        Map<String, dynamic> dreamJson = dream.toJson();

        return dreamJson;
      }).toList();

      // Convertir la lista de mapas en un String JSON manualmente
      content = '[\n';
      for (var dreamJson in dreamsJson) {
        content += '  {\n';
        dreamJson.forEach((key, value) {
          if (value is String || value is DateTime){
            content += '    "$key": "${value.toString().replaceAll('"', '"')}",\n';
          }else{
            content += '    "$key": ${value.toString().replaceAll('"', '"')},\n';
          }

        });
        content = content.substring(0, content.length - 2); // Eliminar la última coma
        content += '\n  },\n';
      }
      content = content.substring(0, content.length - 2); // Eliminar la última coma y cerrar el array
      content += '\n]';
    } else if (format == 'txt') {
      content = dreams
          .map((dream) {
        // Convertir el objeto Dream a un mapa usando toJson()
        Map<String, dynamic> dreamJson = dream.toJson();

        // Formatear las fechas y horas antes de agregar a la cadena
        String formattedFecha = DateFormat('d MMM, yyyy', 'es_ES').format(dream.date!);
        String formattedHoraInicio = dream.dreamStart != null ? DateFormat('HH:mm', 'es_ES').format(dream.dreamStart!) : 'Sin hora de inicio';
        String formattedHoraFinal = dream.dreamEnd != null ? DateFormat('HH:mm', 'es_ES').format(dream.dreamEnd!) : 'Sin hora de finalización';

        return '''
                Título: ${dreamJson['titulo'] ?? 'Sin titulo'}
                Descripción: ${dreamJson['descripcion'] ?? 'Sin descripcion'}
                Característica: ${dreamJson['caracteristica'] ?? 'Sin caracteristica'}
                Fecha: $formattedFecha
                Hora de Inicio: $formattedHoraInicio
                Hora de Final: $formattedHoraFinal
                Calidad: ${dreamJson['calidad'] ?? 'Sin calidad'}
                Lúcido: ${dreamJson['lucido'] == true ? 'Sí' : 'No'}
                ---------------
                ''';
      })
          .join('\n');
    }

    file = await _saveToFile(content, format);

    if (file != null) {
      // Si el archivo se guardó correctamente, puedes abrirlo
      print('Archivo exportado exitosamente.');
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      await FlutterFileDialog.saveFile(params: params);
      //OpenFile.open(file.path); // Abrir el archivo
      return true; // Retorna true si todo salió bien
    } else {
      print('Hubo un error al guardar el archivo.');
      return false; // Retorna false si hubo un error al guardar el archivo
    }

  }

  Future<File?> _saveToFile(String content, String format) async {
    // Obtener el directorio de Documentos en el almacenamiento externo
    Directory? directory = await getExternalStorageDirectory();

    if (directory != null) {
      // Encontrar la carpeta Documents dentro del almacenamiento externo
      directory = await getDirectory();
    }

    // Asegúrate de que la carpeta exista
    if (!directory!.existsSync()) {
      await directory.create(recursive: true);
    }

    // Crear el nombre del archivo con fecha actual (ejemplo: export_dreams_2025_04_27.txt)
    String formattedDate = DateFormat('yyyy_MM_dd').format(DateTime.now());
    String fileName = 'Velaris_export$formattedDate-${DateTime.now().millisecondsSinceEpoch}.$format';
    String filePath = '${directory.path}/$fileName';
    File file = File(filePath);

    // Guardar el archivo
    if (format == 'txt') {
      // Para TXT, agregar BOM al principio para asegurar la codificación UTF-8
      List<int> utf8BytesWithBom = [
        0xEF, 0xBB, 0xBF, // BOM
        ...utf8.encode(content), // Contenido UTF-8
      ];
      await file.writeAsBytes(utf8BytesWithBom);
    } else {
      // Para JSON, guardarlo normalmente en UTF-8
      await file.writeAsString(content, encoding: utf8);
    }

    print('Archivo guardado en: $filePath');

    return file; // Regresar el archivo guardado
  }
}