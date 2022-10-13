import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:calories_counter_project/screens/historyOfday_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  final CollectionReference trackCollection =
  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("food_track");

  bool isChange = false;

  @override
  Widget build(BuildContext context) {
    bool useKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5fb27c),
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,

        title: Text(
          isChange
              ? "น้ำหนัก"
              : "แคลอรี่",
          style: TextStyle(fontWeight: FontWeight.bold,
          ),textScaleFactor: 1.5,
        ),
      ),
      body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: DateTime(2022),
                    lastDay: DateTime.now(),
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat;
                        });
                      }
                    },
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    daysOfWeekVisible: true,
                    selectedDayPredicate: (DateTime date){
                      return isSameDay(_selectedDay, date);
                    },
                    onDaySelected: (selectedDay, focusedDay){
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return HistoryOfDay(date: selectedDay,);
                      }));
                    },

                    calendarBuilders: CalendarBuilders(
                      headerTitleBuilder: (context, day){
                        final String text;
                        switch (day.month) {
                          case 1:
                            text = "มกราคม";
                            break;
                          case 2:
                            text = "กุมภาพันธ์";
                            break;
                          case 3:
                            text = "มีนาคม";
                            break;
                          case 4:
                            text = "เมษายน";
                            break;
                          case 5:
                            text = "พฤษภาคม";
                            break;
                          case 6:
                            text = "มิถุนายน";
                            break;
                          case 7:
                            text = "กรกฎาคม";
                            break;
                          case 8:
                            text = "สิงหาคม";
                            break;
                          case 9:
                            text = "กันยายน";
                            break;
                          case 10:
                            text = "ตุลาคม";
                            break;
                          case 11:
                            text = "พฤศจิกายน";
                            break;
                          case 12:
                            text = "ธันวาคม";
                            break;
                          default:
                            text = "Undefined";
                            break;
                        }
                        return Center(
                          child: Text(
                            "$text ${day.yearInBuddhistCalendar}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),
                          ),
                        );
                      },
                      todayBuilder: (context, day, focusedDay){
                        return StreamBuilder(
                          stream: trackCollection.doc("${day.day}-${day.month}-${day.yearInBuddhistCalendar}").snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData || !snapshot.data.exists) {
                              return Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(2),
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  //color: Colors.green
                                  border: Border.all(
                                      color: isChange ? Colors.blue.shade900 : Color(0xFF00b752)
                                  ),
                                  borderRadius: BorderRadius.circular(10),

                                ),
                                child: Stack(
                                  children:  [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "${day.day}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),textScaleFactor: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(2),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: isChange ? Colors.blue.shade900.withOpacity(0.1) : Color(0xFF00b752).withOpacity(0.1),
                                border: Border.all(
                                    color: isChange ? Colors.black : Colors.black
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children:  [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${day.day}",
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent,
                                          fontWeight: FontWeight.bold
                                      ),textScaleFactor: 1.0,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(isChange ?"${snapshot.data!["weight"]}" :
                                    "${snapshot.data!["caloriesEaten"]}",
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent,
                                          fontWeight: FontWeight.bold
                                      ),textScaleFactor: 1.0,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },

                      dowBuilder: (context, day){
                        final String text;
                        switch (day.weekday) {
                          case DateTime.sunday:
                            text = DateFormat("อา").format(day);
                            break;
                          case DateTime.monday:
                            text = DateFormat("จ").format(day);
                            break;
                          case DateTime.tuesday:
                            text = DateFormat("อ").format(day);
                            break;
                          case DateTime.wednesday:
                            text = DateFormat("พ").format(day);
                            break;
                          case DateTime.thursday:
                            text = DateFormat("พฤ").format(day);
                            break;
                          case DateTime.friday:
                            text = DateFormat("ศ").format(day);
                            break;
                          case DateTime.saturday:
                            text = DateFormat("ส").format(day);
                            break;
                          default:
                            text = DateFormat("Undefined").format(day);
                            break;
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              text,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),textScaleFactor: 1.0,
                            ),

                          ],
                        );
                      },
                      outsideBuilder: (context, day, focusedDay){
                        return StreamBuilder(
                          stream: trackCollection.doc("${day.day}-${day.month}-${day.yearInBuddhistCalendar}").snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData || !snapshot.data.exists) {
                              return Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(2),
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children:  [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "${day.day}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                        ),textScaleFactor: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(2),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children:  [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${day.day}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold
                                      ),textScaleFactor: 1.0,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(isChange ? "${snapshot.data!["weight"]}"
                                      : "${snapshot.data!["caloriesEaten"]}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold
                                      ),textScaleFactor: 1.0,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      disabledBuilder: (context, day, focusedDay){
                        return StreamBuilder(
                          stream: trackCollection.doc("${day.day}-${day.month}-${day.yearInBuddhistCalendar}").snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData || !snapshot.data.exists) {
                              return Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(2),
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children:  [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "${day.day}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                        ),textScaleFactor: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(2),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children:  [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${day.day}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold
                                      ),textScaleFactor: 1.0,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(isChange ?"${snapshot.data!["weight"]}" :
                                    "${snapshot.data!["caloriesEaten"]}",
                                      style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.bold
                                      ),textScaleFactor: 1.0,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      //Datetime.now()
                      selectedBuilder: (context, day, focusedDay){
                        return StreamBuilder(
                          stream: trackCollection.doc("${day.day}-${day.month}-${day.yearInBuddhistCalendar}").snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData || !snapshot.data.exists) {
                              return Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(2),
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  //color: Colors.green
                                  border: Border.all(
                                      color: isChange ? Colors.blue.shade900 : Color(0xFF00b752)
                                  ),
                                  borderRadius: BorderRadius.circular(10),

                                ),
                                child: Stack(
                                  children:  [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "${day.day}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),textScaleFactor: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(2),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: isChange ? Colors.blue.shade900 : Color(0xFF00b752),
                                border: Border.all(
                                    color: isChange ? Colors.blue.shade900 : Color(0xFF00b752)
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children:  [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${day.day}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),textScaleFactor: 1.0,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(isChange ?"${snapshot.data!["weight"]}" :
                                    "${snapshot.data!["caloriesEaten"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),textScaleFactor: 1.0,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },

                      defaultBuilder: (context, day, focusedDay){
                        return StreamBuilder(
                          stream: trackCollection.doc("${day.day}-${day.month}-${day.yearInBuddhistCalendar}").snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData || !snapshot.data.exists) {
                              return Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(2),
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: isChange ? Color(0xFF00b752) : Colors.blue.shade900
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children:  [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "${day.day}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),textScaleFactor: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(2),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: isChange ? Color(0xFF00b752) : Colors.blue.shade900
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children:  [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${day.day}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),textScaleFactor: 1.0,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      isChange ?"${snapshot.data!["weight"]}" :
                                      "${snapshot.data!["caloriesEaten"]}",
                                      style: TextStyle(
                                          color: isChange ? Colors.blue : Color(0xFF00b752),
                                          fontWeight: FontWeight.bold
                                      ),textScaleFactor: 1.0,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    headerStyle: HeaderStyle(
                        formatButtonShowsNext: false,
                        formatButtonVisible: false,
                        formatButtonTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        formatButtonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepPurpleAccent
                        )
                    ),
                  ),
                ),
              ],
            ),
      ),
      floatingActionButton: Visibility(
        visible: !useKeyboard,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton(
            heroTag: "Change",
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: const Color(0xFF00aca0),
            foregroundColor: Colors.white,
            child: isChange
                ? Icon(Icons.fastfood_rounded)
                : Icon(Icons.fitness_center_rounded),
            onPressed: () {
              setState(() {
                isChange = !isChange;
              });
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}
