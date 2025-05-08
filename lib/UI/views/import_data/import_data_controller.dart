import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../model/entity/dream.dart';
import '../../../service/firestore_service.dart';

class ImportDataController {
  final firestoreService = FirestoreService();

  // Método para importar el archivo JSON
  Future<File?> getFile() async {
    // Permitir seleccionar cualquier tipo de archivo
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      String? path = result.files.single.path;
      if (path != null && path.endsWith('.json')) {
        return File(path);
      } else {
        print('El archivo seleccionado no es un .json valido.');
      }
    } else {
      print('No se selecciono ningun archivo.');
    }

    return null;
  }

  Future<bool> importDreamsFromFile(File file) async {
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
      return true;
    } catch (e) {
      print('Error al importar los datos: $e');
      return false;
    }
  }
}