import 'package:cendrassos/models/notificacio.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendariNotificacions extends StatelessWidget {
  final List<Notificacio> notificacions;
  final DateTime selectedDay;
  final DateTime focusedDay;

  final MonthChangeCallBack onMonthChange;
  final SelectedDayCallBack onSelectDay;

  final ValueNotifier<List<Notificacio>> _selectedEvents =
      ValueNotifier<List<Notificacio>>([]);

  CalendariNotificacions({
    required this.notificacions,
    required this.focusedDay,
    required this.selectedDay,
    required this.onMonthChange,
    required this.onSelectDay,
  });

  DateTime getFirstCourseDay() {
    int mes = DateTime.now().month;
    if (mes > 9) {
      return DateTime.utc(DateTime.now().year, 9, 1);
    } else {
      return DateTime.utc(DateTime.now().year - 1, 9, 1);
    }
  }

  DateTime getLastCourseDay() {
    var dia = getFirstCourseDay();
    return DateTime.utc(dia.year + 1, 7, 31);
  }

  List<Notificacio> _getEventsForDay(DateTime day) {
    return notificacions.where((n) => DateUtils.isSameDay(n.dia, day)).toList();
  }

  void _selectDay(DateTime selected, DateTime focused) {
    onSelectDay(selected, focused);
  }

  @override
  Widget build(BuildContext context) {
    _selectedEvents.value = _getEventsForDay(selectedDay);

    return Column(children: [
      TableCalendar<Notificacio>(
          firstDay: getFirstCourseDay(),
          lastDay: getLastCourseDay(),
          focusedDay: focusedDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          weekendDays: [DateTime.saturday, DateTime.sunday],
          // Desactivar dissabtes i diumenges
          enabledDayPredicate: (date) {
            return (date.weekday != DateTime.sunday &&
                date.weekday != DateTime.saturday);
          },
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
          ),
          calendarFormat: CalendarFormat.month,
          eventLoader: _getEventsForDay,
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          onDaySelected: _selectDay,
          onFormatChanged: (format) {},
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          onPageChanged: (focusedDay) {
            onMonthChange(focusedDay);
          },
          calendarBuilders:
              CalendarBuilders(singleMarkerBuilder: (context, date, event) {
            Color c = event.getColor();
            return Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: c),
              width: 7.0,
              height: 7.0,
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
            );
          }),
          locale: "ca_ES"),
      const SizedBox(height: 8.0),
      Center(
        child: Text(
          'Dia: ${selectedDay.day}/${selectedDay.month}/${selectedDay.year}',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            decorationColor: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
      Expanded(
        child: ValueListenableBuilder<List<Notificacio>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: value[index].getColor(),
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      onTap: () => print('${value[index]}'),
                      title: Text('${value[index]}'),
                    ),
                  );
                },
              );
            }),
      ),
    ]);
  }
}

typedef SelectedDayCallBack = void Function(
    DateTime selected, DateTime focused);

typedef MonthChangeCallBack = void Function(DateTime focused);
