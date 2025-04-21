import 'package:flutter/material.dart';
import 'package:velaris/UI/views/login/login_view.dart';
import 'package:velaris/UI/views/register/register_controller.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatPassword = TextEditingController();
  TextEditingController nickname = TextEditingController();
  TextEditingController dob = TextEditingController();
  DateTime? selectedDate;
  RegisterController registerController = RegisterController();

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF190B2C),
      body: Center(
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
                'Registrate',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Inserta tus datos:',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 24),

              // Correo
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Correo:", style: TextStyle(color: Colors.white70)),
              ),
              const SizedBox(height: 4),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: email,
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
              ),
              const SizedBox(height: 12),

              // Nickname
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nombre de usuario:",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: nickname,
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
              ),
              const SizedBox(height: 12),

              // Contraseña
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contraseña:",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                obscureText: true,
                controller: password,
                style: const TextStyle(color: Colors.white),
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
              ),
              const SizedBox(height: 12),

              // Repetir contraseña
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Repetir contraseña:",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                obscureText: true,
                controller: repeatPassword,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
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
              ),
              const SizedBox(height: 12),

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
                controller: dob,
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF1E1A2E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "YYYY-MM-DD",
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
                      dob.text =
                          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
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
                    if (password.text != repeatPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Las contraseñas no coinciden')),
                      );
                      return;
                    }

                    if (password.text.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('La contraseña debe tener al menos 6 caracteres')),
                      );
                      return;
                    }

                    if (selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Selecciona tu fecha de nacimiento')),
                      );
                      return;
                    }

                    bool comprobacion = await registerController.register(
                      email.text,
                      password.text,
                      nickname.text,
                      selectedGender ?? '',
                      DateTime.parse(dob.text),
                    );

                    if (comprobacion) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
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
            ],
          ),
        ),
      ),
    );
  }
}
