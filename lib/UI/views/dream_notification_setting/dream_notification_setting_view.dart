import 'package:flutter/material.dart';

import 'dream_notification_setting_controller.dart';

class DreamNotificationSettingView extends StatefulWidget {
  const DreamNotificationSettingView({super.key});

  @override
  State<DreamNotificationSettingView> createState() =>
      _DreamNotificationSettingViewState();
}

class _DreamNotificationSettingViewState
    extends State<DreamNotificationSettingView> {
  DreamNotificationSettingController dreamNotificationSettingController = DreamNotificationSettingController();
  bool notificationsEnabled = true;
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await dreamNotificationSettingController.initialize();
    selectedTime = await dreamNotificationSettingController.getHour();
    notificationsEnabled = (await dreamNotificationSettingController.getHourActivation())??true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2643),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Ajustes de notificaciones',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'Habilitar notificaciones:',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          value: notificationsEnabled,
                          activeColor: const Color(0xFFDB63FF),
                          onChanged: (value) {
                            setState(() {
                              notificationsEnabled = value;
                            });
                          },
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'Hora que saldrá la notificación:',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (picked != null && picked != selectedTime) {
                              setState(() {
                                selectedTime = picked;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1D1033),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              dreamNotificationSettingController.setHour(selectedTime);
                              dreamNotificationSettingController.setHourActivation(notificationsEnabled);
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text("Ajustes actualizados correctamente."),
                                ),
                              );
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
                                  'Guardar cambios',
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