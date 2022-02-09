import 'package:cendrassos/notificacions_repository.dart';
import 'package:cendrassos/models/djau.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/notificacio.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<Dashboard> {
  Alumne? alumne;
  NotificacionsRepository api = NotificacionsRepository();

  List<Notificacio> _notificacions = [];

  /// Notificacions
  // LinkedHashMap<DateTime, List<Notificacio>> _notificacions = LinkedHashMap();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late final ValueNotifier<List<Notificacio>> _selectedEvents;
  DateTime? _selectedDay;
  DateTime? kFirstDay;
  DateTime? kLastDay;

  DateTime getFirstCourseDay() {
    int mes = DateTime.now().month;
    if (mes > 9) {
      return DateTime.utc(DateTime.now().year, 9, 1);
    } else {
      return DateTime.utc(DateTime.now().year - 1, 9, 1);
    }
  }

  @override
  void initState()  {

    _getEventsForMonth(DateTime.now().month);
    super.initState();
    kFirstDay = getFirstCourseDay();
    kLastDay = DateTime.utc(kFirstDay!.year + 1, 7, 31);

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }


  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  // Obtenir els events del dia
  List<Notificacio> _getEventsForDay(DateTime day) {
    return _notificacions.where((n) => DateUtils.isSameDay(n.dia,day)).toList();
  }

  void _getEventsForMonth(int month) {
    Future.delayed(Duration.zero,() async {
      var notificacions = await api
          .getNotifications(month);
      setState(() {
        _notificacions = notificacions;
      });

    });
  }

  // Què fer quan es selecciona un dia concret
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLogin = context.watch<DjauModel>();
    var username = currentLogin.usernamame;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Alumne: $username',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.account_box),
              onPressed: () {}, // TODO Afegir alumne o switch
              color: Colors.white)
        ],
        backgroundColor: const Color.fromRGBO(217, 48, 29, 1),
      ),
      body: Column(
        children: [
          TableCalendar<Notificacio>(
              firstDay: kFirstDay!,
              lastDay: kLastDay!,
              focusedDay: _focusedDay,
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
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                // TODO: Carregar notificacions del mes??
                _getEventsForMonth(focusedDay.month);
                _focusedDay = focusedDay;
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
              'Dia: ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
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
        ],
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   final currentLogin = context.watch<DjauModel>();

//   var username = currentLogin.usernamame;

//   return Scaffold(
//     appBar: AppBar(
//       title: Text('TableCalendar Example'),
//     ),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(height: 20.0),
//           ElevatedButton(
//             child: Text('Basics'),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => TableBasicsExample()),
//             ),
//           ),
//           const SizedBox(height: 12.0),
//           ElevatedButton(
//             child: Text('Range Selection'),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => TableRangeExample()),
//             ),
//           ),
//           const SizedBox(height: 12.0),
//           ElevatedButton(
//             child: Text('Events'),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => TableEventsExample()),
//             ),
//           ),
//           const SizedBox(height: 12.0),
//           ElevatedButton(
//             child: Text('Multiple Selection'),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => TableMultiExample()),
//             ),
//           ),
//           const SizedBox(height: 12.0),
//           ElevatedButton(
//             child: Text('Complex'),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => TableComplexExample()),
//             ),
//           ),
//           const SizedBox(height: 20.0),
//         ],
//       ),
//     ),
//   );
// }
}
