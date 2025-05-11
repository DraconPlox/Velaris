import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velaris/model/entity/dream_user.dart';

import '../../widgets/user_profile_picture.dart';
import 'edit_profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  EditProfileController editProfileController = EditProfileController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  DateTime selectedDate = DateTime(2004, 10, 15);
  String selectedGender = 'Hombre';
  List<String> genderOptions = ['Hombre', 'Mujer', 'Otro'];
  File? pickedImage;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    await editProfileController.initialize();
    DreamUser? user = editProfileController.getDreamUser();
    if (user == null) return;

    final doc =
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user?.id ?? "")
            .get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        nameController.text = data['nickname'] ?? '';
        descController.text = data['description'] ?? '';
        selectedDate = (data['dob'] as Timestamp).toDate();
        selectedGender = data['gender'] ?? 'Otro';
      });
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              surface: Color(0xFF2D2643),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF1D1033),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image
    );
    if (result != null) {
      setState(() {
        pickedImage = File(result.files.single.path!);
      });
    }
  }

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
          'Editar perfil',
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D2643),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Imagen de perfil
                          Center(
                            child: GestureDetector(
                              onTap: pickImage,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.transparent,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(999),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.4), // oscurece la imagen
                                          BlendMode.darken,
                                        ),
                                        child: pickedImage == null
                                            ? Image.network(
                                          editProfileController.getDreamUser()?.profilePicture ??
                                              "https://firebasestorage.googleapis.com/v0/b/velaris-5a288.firebasestorage.app/o/profile_pictures%2Fdefault.png?alt=media&token=d6d2a455-c6f2-4870-80ec-ff4df67d1ddd",
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        )
                                            : Image.file(
                                          pickedImage!,
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Icono de camara centrado
                                  const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white70,
                                    size: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Campo de nombre
                          TextField(
                            controller: nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              labelStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: const Color(0xFF2D2643),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Campo de descripción
                          TextField(
                            controller: descController,
                            style: const TextStyle(color: Colors.white),
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: 'Descripción',
                              labelStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: const Color(0xFF2D2643),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Fecha de nacimiento
                          Row(
                            children: [
                              const Text(
                                'Fecha de Nacimiento:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.calendar_today, color: Colors.white),
                                onPressed: () => _pickDate(context),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Género
                          Row(
                            children: [
                              const Text(
                                'Género:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedGender,
                                  dropdownColor: const Color(0xFF2D2643),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFF2D2643),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  items:
                                      genderOptions.map((String gender) {
                                        return DropdownMenuItem<String>(
                                          value: gender,
                                          child: Text(gender),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Botón para guardar cambios
                          SizedBox(
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () async {
                                if (nameController.text != "" && descController.text != "") {
                                  bool result = await editProfileController.updateUser(
                                    pickedImage: pickedImage,
                                    nickname: nameController.text,
                                    description: descController.text,
                                    selectedDate: selectedDate,
                                    gender: selectedGender,
                                  );

                                  if (result) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Datos actualizados exitosamente!'),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error al actualizar los datos')),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('El nombre o descripción no pueden estar vacios.')),
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFB04CFF), Color(0xFF7E5EFF)],
                                    // Puedes ajustar estos colores si es necesario
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Guardar cambios',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
