import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:velaris/UI/views/list_dreams/list_dreams_view.dart';

class MyCalendarWidget extends StatefulWidget {
  final void Function(DateTime selectedDay)? onDaySelected;

  const MyCalendarWidget({Key? key, this.onDaySelected}) : super(key: key);

  @override
  _MyCalendarWidgetState createState() => _MyCalendarWidgetState();
}


class _MyCalendarWidgetState extends State<MyCalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _goToPreviousMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
    });
  }

  void _goToList() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ListDreamsView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left, color: Colors.white),
                onPressed: _goToPreviousMonth,
              ),

              Text(
                DateFormat.yMMMM().format(_focusedDay),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),

              IconButton(
                icon: Icon(Icons.chevron_right, color: Colors.white),
                onPressed: _goToNextMonth,
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: _goToList,
              ),
            ],
          ),
        ),

        TableCalendar(
          locale: 'es_ES',
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });

            // Llama al callback que le pasamos desde el widget padre
            widget.onDaySelected!(selectedDay);
          },

          headerVisible: false,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Color(0xFF533F7E),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Color(0x80110F1C),
              shape: BoxShape.circle,
            ),
            defaultTextStyle: TextStyle(color: Colors.white),
            weekendTextStyle: TextStyle(color: Colors.white),
            todayTextStyle: TextStyle(color: Colors.white),
            selectedTextStyle: TextStyle(color: Colors.white),
            outsideTextStyle: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
