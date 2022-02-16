import 'package:cendrassos/cendrassos_theme.dart';
import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/models/notificacio.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';

class CalendariNotificacions extends StatelessWidget {
  final List<Notificacio> notificacions;
  final DateTime? selectedDay;
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
    var year = DateTime.now().year;
    if (mes < startMonth) {
      year = year - 1;
    }
    return DateTime.utc(year, startMonth, 1);
  }

  DateTime getLastCourseDay() {
    var dia = getFirstCourseDay();
    return DateTime.utc(dia.year + 1, endMonth, 31);
  }

  List<Notificacio> _getEventsForDay(DateTime day) {
    return notificacions.where((n) => DateUtils.isSameDay(n.dia, day)).toList();
  }

  void _selectDay(DateTime selected, DateTime focused) {
    onSelectDay(selected, focused);
  }

  String _getSelectedDay() {
    if (selectedDay != null) {
      return "Dia: " + DateFormat('dd/MM/yyyy').format(selectedDay!);
    }
    return "";
  }

  // Crea les caixes de colors de les notificacions de cada
  // un dels dies
  Widget _notificationsBox(Color color, int lenght) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        color: color,
        width: 15,
        height: 15,
        child: Center(
          child: Text(
            lenght.toString(),
            style: TextStyle(
              fontSize: notificationsNumberTextSize,
              color: primaryColorDark,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (selectedDay != null) {
      _selectedEvents.value = _getEventsForDay(selectedDay!);
    }

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
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              if (events.isEmpty) return Container();

              // if (events.length < 5) return null;
              // Si n'hi ha més de quatre no es veuen

              final grups = groupBy(events, (Notificacio e) {
                return e.getColor();
              });

              var controls = <Widget>[];
              grups.forEach((key, value) {
                controls.add(_notificationsBox(key, value.length));
              });

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controls,
              );
            },
            singleMarkerBuilder: (context, date, event) {
              Color c = event.getColor();
              return Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: c),
                width: 6.0,
                height: 6.0,
                margin: const EdgeInsets.symmetric(horizontal: 1),
              );
            },
            selectedBuilder: (context, date, events) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: primaryColorUltraLight,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
            // markerBuilder:
          ),
          locale: "ca_ES"),
      const SizedBox(height: 8.0),
      Center(
        child: Text(
          '${_getSelectedDay()}',
          style: TextStyle(
            fontSize: titleFontSize,
            color: primaryColor,
            decorationColor: primaryColorDark,
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
                padding: EdgeInsets.all(8),
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return CalendarListItem(notificacio: value[index]);
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

class CalendarListItem extends StatelessWidget {
  const CalendarListItem({Key? key, required this.notificacio})
      : super(key: key);

  final Notificacio notificacio;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      child: ListTile(
        // leading: _buildCircleAvatar(value[index].getColor()),
        leading: Column(children: [
          Text(notificacio.tipus.toShortString(),
              style: TextStyle(
                color: notificacio.getColor(),
              )),
          Text("${notificacio.hora} hora"),
        ]),

        onTap: () => print('$notificacio'),
        title: Text(notificacio.professor),
        subtitle: Text('${notificacio.text}'),
      ),
    );
  }
}
