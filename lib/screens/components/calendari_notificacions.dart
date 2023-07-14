import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/models/notificacio.dart';
import 'package:cendrassos/utils/global_navigator.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';

class CalendariNotificacions extends StatelessWidget {
  final List<Notificacio> notificacions;
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final DateTime lastCourseDay;
  final DateTime firstCourseDay;
  final CalendarFormat format;

  final MonthChangeCallBack onMonthChange;
  final SelectedDayCallBack onSelectDay;
  final FormatChanged onFormatChanged;

  final ValueNotifier<List<Notificacio>> _selectedEvents =
      ValueNotifier<List<Notificacio>>([]);

  CalendariNotificacions({
    Key? key,
    required this.notificacions,
    required this.focusedDay,
    required this.selectedDay,
    required this.firstCourseDay,
    required this.lastCourseDay,
    required this.format,
    required this.onMonthChange,
    required this.onSelectDay,
    required this.onFormatChanged,
  }) : super(key: key);

  List<Notificacio> _getEventsForDay(DateTime day) {
    return notificacions.where((n) => DateUtils.isSameDay(n.dia, day)).toList();
  }

  void _selectDay(DateTime selected, DateTime focused) {
    onSelectDay(selected, focused);
  }

  String _getSelectedDay() {
    if (selectedDay != null) {
      return "$etiquetaDia: ${DateFormat('dd/MM/yyyy').format(selectedDay!)}";
    }
    return "";
  }

  // Crea les caixes de colors de les notificacions de cada
  // un dels dies
  Widget _notificationsBox(context, Color color, int lenght) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        color: color,
        width: 15,
        height: 15,
        child: Center(
          child: Text(
            lenght.toString(),
            style: Theme.of(context).textTheme.labelSmall,
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
          firstDay: firstCourseDay,
          lastDay: lastCourseDay,
          focusedDay: focusedDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          weekendDays: const [DateTime.saturday, DateTime.sunday],
          // Desactivar dissabtes i diumenges
          enabledDayPredicate: (date) {
            return (date.weekday != DateTime.sunday &&
                date.weekday != DateTime.saturday);
          },
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
          ),
          calendarFormat: format,
          availableCalendarFormats: const {
            CalendarFormat.month: calendarMostrames,
            CalendarFormat.week: calendariCollapsa,
          },
          eventLoader: _getEventsForDay,
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          onDaySelected: _selectDay,
          onFormatChanged: onFormatChanged,
          headerStyle: const HeaderStyle(
            formatButtonVisible: true,
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
                controls.add(_notificationsBox(context, key, value.length));
              });

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controls,
              );
            },
            selectedBuilder: (context, date, events) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Text(
                  date.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            // markerBuilder:
          ),
          locale: "ca_ES"),
      Center(
        child: Text(
          _getSelectedDay(),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
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
                padding: const EdgeInsets.all(8),
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

typedef FormatChanged = void Function(CalendarFormat format);

class CalendarListItem extends StatelessWidget {
  const CalendarListItem({Key? key, required this.notificacio})
      : super(key: key);

  final Notificacio notificacio;

  void showNotificacio(BuildContext context) {
    GlobalNavigator.showNotificacio(notificacio);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).primaryColorLight,
      child: ListTile(
        // leading: _buildCircleAvatar(value[index].getColor()),
        leading: Column(
          children: [
            Text(
              notificacio.tipus,
              style: TextStyle(
                color: notificacio.getColor(),
              ),
            ),
            Text("${notificacio.hora} $etiquetaHora"),
          ],
        ),
        onTap: () => showNotificacio(context),
        title: Text(
          '$etiquetaProfessor: ${notificacio.professor}',
        ),
        subtitle: Text(notificacio.text),
      ),
    );
  }
}
