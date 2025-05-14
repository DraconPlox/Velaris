import 'package:flutter/material.dart';
import 'package:velaris/UI/views/calendar_dreams/calendar_dreams_view.dart';
import 'package:velaris/UI/views/login/login_view.dart';
import 'package:velaris/UI/views/register/register_controller.dart';
import 'package:velaris/model/entity/dream.dart';

import '../../../model/entity/dream_user.dart';
import 'complete_login_google_controller.dart';

class CompleteLoginGoogleView extends StatefulWidget {
  CompleteLoginGoogleView({super.key, required this.user});
  final DreamUser user;

  @override
  State<CompleteLoginGoogleView> createState() => _CompleteLoginGoogleView();
}

class _CompleteLoginGoogleView extends State<CompleteLoginGoogleView> {
  TextEditingController dobText = TextEditingController();
  String dob = "";
  DateTime? selectedDate;
  CompleteLoginGoogleController completeLoginGoogleController = CompleteLoginGoogleController();

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF190B2C),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2544),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Completa tu perfil',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Necesitamos unos pocos datos más para seguir.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 24),

                // Género
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Género:", style: TextStyle(color: Colors.white70)),
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  dropdownColor: const Color(0xFF1E1A2E),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1E1A2E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  hint: const Text(
                    "Selecciona tu género",
                    style: TextStyle(color: Colors.white54),
                  ),
                  items:
                  ['Hombre', 'Mujer', 'Otro'].map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                const SizedBox(height: 12),

                // Fecha de nacimiento
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Fecha de nacimiento:",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: dobText,
                  readOnly: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1E1A2E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "DD-MM-YYYY",
                    hintStyle: TextStyle(color: Colors.white54),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xFF7A5FFF),
                              surface: Color(0xFF2D2544),
                            ),
                            dialogBackgroundColor: const Color(0xFF1E1A2E),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                        dobText.text =
                        "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                        dob = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),

                // Botón registrarse
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEA6DE7), Color(0xFF7A5FFF)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {

                      if (selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Selecciona tu fecha de nacimiento')),
                        );
                        return;
                      } else {
                        widget.user.dob = selectedDate;
                      }

                      if (selectedGender == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Selecciona tu género')),
                        );
                        return;
                      } else {
                        widget.user.gender = selectedGender;
                      }

                      bool result = await completeLoginGoogleController.register(widget.user);

                      if (result) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalendarDreamsView(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ha habido un error a la hora de crear el usuario.')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
