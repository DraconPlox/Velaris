import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velaris/UI/views/view_dream/view_dream_view.dart';

import '../../../model/entity/dream.dart';
import 'edit_dream_controller.dart';

class EditDreamView extends StatefulWidget {
  final String dreamId;
  const EditDreamView({Key? key, required this.dreamId}) : super(key: key);

  @override
  _EditDreamViewState createState() => _EditDreamViewState();
}

class _EditDreamViewState extends State<EditDreamView> {
  EditDreamController createDreamController = EditDreamController();
  Dream? dream;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    dream = await createDreamController.getDream(widget.dreamId);
    loading = false;

    selectedDate = dream?.date??DateTime.now();
    titulo.text = dream?.title??"";
    descripcion.text = dream?.description??"";
    horaInicio = dream?.dreamStart;
    horaFinal = dream?.dreamEnd;
    caracteristica = dream?.tag;
    estrellasSeleccionadas = dream?.rating??0;
    lucido = dream?.lucid??false;

    setState(() {

    });
  }

  DateTime selectedDate = DateTime.now();
  TextEditingController titulo = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  DateTime? horaInicio;
  DateTime? horaFinal;
  String? caracteristica;
  int estrellasSeleccionadas = 0;
  bool lucido = false;

  FocusNode _focusNodeTitulo = FocusNode();
  FocusNode _focusNodeDescripcion = FocusNode();

  String _monthAbbr(int month) {
    const months = [
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];
    return months[month - 1];
  }

  Widget buildTimeTextField(
      TextEditingController controller,
      String placeholder,
      ) {
    return SizedBox(
      width: 60, // Tamaño del campo de texto
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white, fontSize: 16),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFF2A1E4C),
          hintText: placeholder,
          hintStyle: TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _mostrarSelectorHoraInicio() async {
    DateTime now = DateTime.now();
    final TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (hora != null) {
      setState(() {
        horaInicio = DateTime(
          now.year,
          now.month,
          now.day,
          hora.hour,
          hora.minute,
        );
      });
    }

    _focusNodeDescripcion.unfocus();
    _focusNodeTitulo.unfocus();
  }

  void _mostrarSelectorHoraFinal() async {
    DateTime now = DateTime.now();
    final TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (hora != null) {
      setState(() {
        horaFinal = DateTime(
          now.year,
          now.month,
          now.day,
          hora.hour,
          hora.minute,
        );
      });
    }
    _focusNodeDescripcion.unfocus();
    _focusNodeTitulo.unfocus();
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  Widget buildIconBox(IconData icon, String label, String feature) {
    bool isSelected = caracteristica == feature;

    return GestureDetector(
      onTap: () {
        setState(() {
          caracteristica = isSelected ? null : feature;
        });
      },
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFFB45CFF) : Color(0xFF2A1E4C),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.transparent),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildTimeBox(DateTime? hora) {
    return Row(
      children: [
        timeBox(hora?.hour.toString()),
        SizedBox(width: 4),
        Text(':', style: TextStyle(color: Colors.white, fontSize: 18)),
        SizedBox(width: 4),
        timeBox(hora?.minute.toString()),
      ],
    );
  }

  Widget timeBox(String? text) {
    return Container(
      width: 48,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFF2A1E4C),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text ?? "",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2643),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Editar sueño',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            bottom: 400,
          ),
          // Contenido principal
          SafeArea(
            child: Column(
              children: [
                // Espacio para AppBar
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D2643),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                  initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
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
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.white70,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    _isToday(selectedDate)
                                        ? 'Hoy'
                                        : '${selectedDate.day.toString().padLeft(2, '0')} '
                                        '${_monthAbbr(selectedDate.month)}, ${selectedDate.year}',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: titulo,
                              maxLength: 100,
                              focusNode: _focusNodeTitulo,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                counterStyle: TextStyle(color: Colors.white38),
                                filled: true,
                                fillColor: Color(0xFF2A1E4C),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Titulo',
                                hintStyle: TextStyle(color: Colors.white38),
                              ),
                              buildCounter:
                                  (
                                  BuildContext context, {
                                required int currentLength,
                                required bool isFocused,
                                required int? maxLength,
                              }) => null,
                            ),
                            SizedBox(height: 10),
                            Divider(
                              color: Colors.white30,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xFF2A1E4C),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Color(0xFF2A1E4C),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  child: TextField(
                                    controller: descripcion,
                                    maxLines: null,
                                    expands: true,
                                    focusNode: _focusNodeDescripcion,
                                    style: TextStyle(color: Colors.white70),
                                    keyboardType: TextInputType.multiline,
                                    scrollPhysics: BouncingScrollPhysics(),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Descripcion',
                                      hintStyle: TextStyle(color: Colors.white38),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(
                              color: Colors.white30,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Horario de sueño:',
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => _mostrarSelectorHoraInicio(),
                                  child: buildTimeBox(horaInicio),
                                ),
                                Text(
                                  '-',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _mostrarSelectorHoraFinal(),
                                  child: buildTimeBox(horaFinal),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Caracteristica del sueño:',
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildIconBox(
                                  FontAwesomeIcons.rotateLeft,
                                  'Recurrente',
                                  'Recurrente',
                                ),
                                buildIconBox(
                                  FontAwesomeIcons.ghost,
                                  'Pesadilla',
                                  'Pesadilla',
                                ),
                                buildIconBox(
                                  Icons.accessibility,
                                  'Parálisis del sueño',
                                  'Parálisis del sueño',
                                ),
                                buildIconBox(
                                  FontAwesomeIcons.clock,
                                  'Falso despertar',
                                  'Falso despertar',
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Calidad de sueño:',
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      estrellasSeleccionadas = index + 1;
                                    });
                                  },
                                  child: Icon(
                                    index < estrellasSeleccionadas
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 32,
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  '¿Ha sido lúcido?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(),
                                Checkbox(
                                  value: lucido,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      lucido = newValue ?? false;
                                    });
                                  },
                                  activeColor: Colors.white,
                                  checkColor: Colors.black,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFFB84DFF), Color(0xFF5D5FEF)],
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  await createDreamController.updateDream(
                                    dreamId: dream?.id??"",
                                    title: titulo.text,
                                    date: selectedDate,
                                    description: descripcion.text,
                                    dreamStart: horaInicio,
                                    dreamEnd: horaFinal,
                                    tag: caracteristica,
                                    rating: estrellasSeleccionadas,
                                    lucid: lucido,
                                  );

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => ViewDreamView(dreamId: dream?.id??"")));
                                },
                                child: Text(
                                  'Guardar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (loading)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withAlpha(150),
              child: Center(
                  child: CircularProgressIndicator()
              ),
            )
        ],
      ),
    );
  }
}