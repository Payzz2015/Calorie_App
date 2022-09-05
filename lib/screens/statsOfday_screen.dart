import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:calories_counter_project/helpers/dayofWeek.dart';
import 'package:calories_counter_project/models/Day.dart';
import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/screens/history_screen.dart';
import 'package:calories_counter_project/screens/meal/meal_breakfast.dart';
import 'package:calories_counter_project/screens/meal/meal_dinner.dart';
import 'package:calories_counter_project/screens/meal/meal_lunch.dart';
import 'package:calories_counter_project/screens/meal/meal_snack.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  //date
  late DateTime datePicked;
  DateTime _value = DateTime.now();
  var now = DateTime.now();
  var onlyBuddhistYear = DateTime.now().yearInBuddhistCalendar;
  DateTime today = DateTime.now();
  Color _rightArrowColor = Color(0xFF5fb27c);
  Color _leftArrowColor = Colors.white;

  bool dateCheck() {
    DateTime formatPicked =
        DateTime(onlyBuddhistYear, datePicked.month, datePicked.day);
    DateTime formatToday = DateTime(onlyBuddhistYear, today.month, today.day);
    if (formatPicked.compareTo(formatToday) == 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget _showDatePicker() {
    return Container(
      width: 360,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_left, size: 30.0),
            color: _leftArrowColor,
            onPressed: () {
              setState(() {
                _value = _value.subtract(Duration(days: 1));
                _rightArrowColor = Colors.white;
                _leftArrowColor = Colors.white;
              });
            },
          ),
          Text(
            _dateFormatter(_value),
            style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          IconButton(
              icon: Icon(Icons.arrow_right, size: 30.0),
              color: _rightArrowColor,
              onPressed: () {
                if (today.difference(_value).compareTo(Duration(days: 1)) ==
                    -1) {
                  setState(() {
                    _rightArrowColor = Color(0xFF5fb27c);
                  });
                } else {
                  setState(() {
                    _value = _value.add(Duration(days: 1));
                  });
                  if (today.difference(_value).compareTo(Duration(days: 1)) ==
                      -1) {
                    setState(() {
                      _rightArrowColor = Color(0xFF5fb27c);
                    });
                  }
                }
              }),
        ],
      ),
    );
  }

  String _dateFormatter(DateTime tm) {
    DateTime today = new DateTime.now();
    Duration oneDay = new Duration(days: 1);
    Duration twoDay = new Duration(days: 2);
    String month;
    switch (tm.month) {
      case 1:
        month = "มกราคม";
        break;
      case 2:
        month = "กุมภาพันธ์";
        break;
      case 3:
        month = "มีนาคม";
        break;
      case 4:
        month = "เมษายน";
        break;
      case 5:
        month = "พฤษภาคม";
        break;
      case 6:
        month = "มิถุนายน";
        break;
      case 7:
        month = "กรกฎาคม";
        break;
      case 8:
        month = "สิงหาคม";
        break;
      case 9:
        month = "กันยายน";
        break;
      case 10:
        month = "ตุลาคม";
        break;
      case 11:
        month = "พฤศจิกายน";
        break;
      case 12:
        month = "ธันวาคม";
        break;
      default:
        month = "Undefined";
        break;
    }
    Duration difference = today.difference(tm);
    if (difference.compareTo(oneDay) < 1) {
      return "วันนี้, ${tm.day} $month ${onlyBuddhistYear}";
    } else if (difference.compareTo(twoDay) < 1) {
      return "เมื่อวาน, ${tm.day} $month ${onlyBuddhistYear}";
    } else {
      return "${daysOfWeek[tm.weekday]}, ${tm.day} $month ${onlyBuddhistYear}";
    }
  }


  Users users = Users();
  User? user = FirebaseAuth.instance.currentUser;
  Future<DocumentSnapshot<Map<String, dynamic>>> userData = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
  Day _day = Day();

  //user data
  /*@override
  void initState() {
    super.initState();
  }
*/
  @override
  Widget build(BuildContext context) {
    bool useKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5fb27c),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "หน้าหลัก",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (conetext) {
                  return const HistoryScreen();
                }));
              },
              icon: Icon(
                Icons.calendar_month_rounded,
                size: 25,
              ))
        ],
      ),
      body: StreamBuilder(
        //stream: FirebaseFirestore.instance.collection(users.uid!+"meals").doc("${_value}").snapshots(),
        // stream: _value,
        builder: (context, AsyncSnapshot snapshot) {
          /*if (!snapshot.hasData || !snapshot.data.exists) {
                  return const Center(
                  );
                }*/
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  PreferredSize(
                    preferredSize: const Size.fromHeight(5.0),
                    child: Container(
                      color: Color(0xFF5fb27c),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _showDatePicker(),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                "แคลอรี่ที่เหลือ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 15,),
                              Text("5000")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("คาร์โบไฮเดรต"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("ไขมัน"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("โปรตีน"),
                              SizedBox(
                                width: 10,
                              ),
                              Text("โซเดียม"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListTile(
                        title: Text(
                          "มื้อเช้า",
                          style: TextStyle(fontSize: 30),
                        ),
                        /*subtitle: const Text(
                              'Fines: Crossing double line\novertaking on pedestrian crossing'),*/
                        trailing: Wrap(spacing: 3, children: <Widget>[
                          IconButton(
                              onPressed: () {


                              },
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color: Color(0xFF5fb27c),
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return mealBreakfast(date: _value);
                                }));
                              },
                              icon: Icon(
                                Icons.add,
                                color: Color(0xFF5fb27c),
                              )),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListTile(
                        title: Text(
                          "มื้อกลางวัน",
                          style: TextStyle(fontSize: 30),
                        ),
                        /*subtitle: const Text(
                              'Fines: Crossing double line\novertaking on pedestrian crossing'),*/
                        trailing: Wrap(spacing: 3, children: <Widget>[
                          IconButton(
                              onPressed: () {

                              },
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color: Color(0xFF5fb27c),
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return mealLunch(date: _value);
                                }));
                              },
                              icon: Icon(
                                Icons.add,
                                color: Color(0xFF5fb27c),
                              )),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListTile(
                        title: Text(
                          "มื้อเย็น",
                          style: TextStyle(fontSize: 30),
                        ),
                        /*subtitle: const Text(
                              'Fines: Crossing double line\novertaking on pedestrian crossing'),*/
                        trailing: Wrap(spacing: 3, children: <Widget>[
                          IconButton(
                              onPressed: () {

                              },
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color: Color(0xFF5fb27c),
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return mealDinner(date: _value);
                                }));
                              },
                              icon: Icon(
                                Icons.add,
                                color: Color(0xFF5fb27c),
                              )),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListTile(
                        title: Text(
                          "มื้อว่าง",
                          style: TextStyle(fontSize: 30),
                        ),
                        /*subtitle: const Text(
                              'Fines: Crossing double line\novertaking on pedestrian crossing'),*/
                        trailing: Wrap(spacing: 3, children: <Widget>[
                          IconButton(
                              onPressed: () {

                              },
                              icon: Icon(
                                Icons.qr_code_rounded,
                                color: Color(0xFF5fb27c),
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return mealSnack(date: _value);
                                }));
                              },
                              icon: Icon(
                                Icons.add,
                                color: Color(0xFF5fb27c),
                              )),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 65,
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Visibility(
        visible: !useKeyboard,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton(
            heroTag: "camera",
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: const Color(0xFF00aca0),
            foregroundColor: Colors.white,
            child: const Icon(Icons.camera_alt_rounded),
            onPressed: () {},
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}
