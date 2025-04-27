import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../model/entity/dream.dart';
import '../../../service/firestore_service.dart';

class ImportDataController {
  final firestoreService = FirestoreService();

  // Método para importar el archivo JSON
  Future<File?> getFile() async {
    // Abrir el selector de archivos para elegir el archivo JSON
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      return file;
    } else {
      print('No se seleccionó ningún archivo.');
    }
  }

  Future<void> importDreamsFromFile(File file) async {
    try {
      // Leer el contenido del archivo
      String fileContent = await file.readAsString();

      // Convertir el contenido a una lista de sueños
      List<dynamic> jsonData = jsonDecode(fileContent);

      // Convertir el JSON en objetos Dream
      List<Dream> dreams = jsonData.map((item) => Dream.fromJson(item)).toList();

      await firestoreService.deleteDreamCollection(FirebaseAuth.instance.currentUser!.uid);

      // Guardar los sueños en Firestore
      for (var dream in dreams) {
        await firestoreService.createDream(dream, FirebaseAuth.instance.currentUser!.uid);
      }

      print('Datos importados con éxito.');
    } catch (e) {
      print('Error al importar los datos: $e');
    }
  }
}