import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:calories_counter_project/helpers/dayofWeek.dart';
import 'package:calories_counter_project/models/Day.dart';
import 'package:calories_counter_project/profiles/gender.dart';
import 'package:calories_counter_project/screens/history_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HistoryOfDay extends StatefulWidget {
  final DateTime date;
  const HistoryOfDay({Key? key,required this.date}) : super(key: key);

  @override
  State<HistoryOfDay> createState() => _HistoryOfDayState(date);
}

class _HistoryOfDayState extends State<HistoryOfDay> {
  final DateTime date;
  _HistoryOfDayState(this.date);
  //date
  late DateTime datePicked;
  late DateTime _value = date;
  var now = DateTime.now();
  var onlyBuddhistYear = DateTime.now().yearInBuddhistCalendar;
  DateTime today = DateTime.now();

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
    return SizedBox(
      width: 360,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _dateFormatter(_value),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _dateFormatter(DateTime tm) {
    DateTime today = DateTime.now();
    Duration oneDay = const Duration(days: 1);
    Duration twoDay = const Duration(days: 2);
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
      return "วันนี้, ${tm.day} $month $onlyBuddhistYear";
    } else if (difference.compareTo(twoDay) < 1) {
      return "เมื่อวาน, ${tm.day} $month $onlyBuddhistYear";
    } else {
      return "${daysOfWeek[tm.weekday]}, ${tm.day} $month $onlyBuddhistYear";
    }
  }

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  final CollectionReference trackCollection =
  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("food_track");

  late Day day = Day();

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    String userTDEE = snap["tdee"];
    String userWeight = snap["weight"];

    DocumentSnapshot trackSnapshot = await trackCollection.doc("${_value.day}-${_value.month}-${_value.yearInBuddhistCalendar}").get();
    day.day = DateFormat.yMMMMd().format(_value);
    day.caloriesLeft = userTDEE;
    day.weight = "0";
    if(day.weight == "0"){
      day.weight = userWeight;
    }
    day.caloriesEaten = "0";
    day.carb = "0";
    day.fat = "0";
    day.protein = "0";
    day.sodium = "0";
    day.breakfast = [];
    day.lunch = [];
    day.dinner = [];
    day.snack = [];
    if(!trackSnapshot.exists){
      await trackCollection.doc("${_value.day}-${_value.month}-${_value.yearInBuddhistCalendar}").set(
          {
            "day": day.day,
            "weight": day.weight,
            "carb": day.carb,
            "fat": day.fat,
            "protein": day.protein,
            "sodium": day.sodium,
            "caloriesLeft": day.caloriesLeft,
            "caloriesEaten": day.caloriesEaten,
            "breakfast": day.breakfast,
            "lunch": day.lunch,
            "dinner": day.dinner,
            "snack": day.snack,
          },SetOptions(merge: true)
      );
    }
  }


  Future checkData() async{
    var check = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    if(check.data()!["name"] == null){
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return const genderSelector();
      }));
    }
  }

  @override
  void initState(){
    checkData();
    _loadUserData();
    super.initState();
  }

  bool isVisibleBreakfast = false;
  bool isVisibleLunch = false;
  bool isVisibleDinner = false;
  bool isVisibleSnack = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Color(0xFF5fb27c),
        centerTitle: true,
        title: const Text(
          "ประวัติ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: trackCollection.doc("${_value.day}-${_value.month}-${_value.yearInBuddhistCalendar}").snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData || !snapshot.data.exists) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        PreferredSize(
                          preferredSize: const Size.fromHeight(5.0),
                          child: Card(
                            elevation: 2,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color(0xFF5fb27c),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _showDatePicker(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: [
                                                FutureBuilder(
                                                    future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
                                                    builder: (context,AsyncSnapshot snapshot){
                                                      return Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            snapshot.connectionState == ConnectionState.waiting
                                                                ? ''
                                                                : '${snapshot.data!['name']}',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 20,
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                ),
                                                SizedBox(height: 30,),
                                                CircularPercentIndicator(
                                                  radius: 100.0,
                                                  lineWidth: 20,
                                                  percent: ((int.parse(snapshot.data["caloriesEaten"])/int.parse(snapshot.data["caloriesLeft"]))*100)/100 > 1
                                                      ? 1
                                                      : ((int.parse(snapshot.data["caloriesEaten"])/int.parse(snapshot.data["caloriesLeft"]))*100)/100,
                                                  center: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("เหลือแคลอรี่",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.blueGrey,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      new Text(((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))) < 0
                                                          ? "แคลอรี่เกิน ${((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))).abs()}"
                                                          :
                                                      ((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))).toString(),
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: ((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))) < 0
                                                              ? 18
                                                              : 35,
                                                          color: ((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))) < 0
                                                              ? Colors.red
                                                              : Colors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  progressColor: ((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))) < 0
                                                      ? Colors.red
                                                      : Colors.green,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("คาร์โบไฮเดรต",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${snapshot.data!["carb"]}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.brown
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  children: [
                                                    Text("ไขมัน",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${snapshot.data!["fat"]}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.green
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  children: [
                                                    Text("โปรตีน",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${snapshot.data!["protein"]}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.redAccent
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Container(
                                            width: 10.0,
                                            height: 10.0,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF5fb27c),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(width: 8,),
                                          Container(
                                            width: 10.0,
                                            height: 10.0,
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              children: [
                                                FutureBuilder(
                                                    future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
                                                    builder: (context,AsyncSnapshot snapshot){
                                                      return Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            snapshot.connectionState == ConnectionState.waiting
                                                                ? ''
                                                                : '${snapshot.data!['name']}',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 20,
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                ),
                                                SizedBox(height: 30,),
                                                CircularPercentIndicator(
                                                  radius: 100.0,
                                                  lineWidth: 20,
                                                  percent: ((int.parse(snapshot.data["caloriesEaten"])/int.parse(snapshot.data["caloriesLeft"]))*100)/100 > 1
                                                      ? 1
                                                      : ((int.parse(snapshot.data["caloriesEaten"])/int.parse(snapshot.data["caloriesLeft"]))*100)/100,
                                                  center: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("เหลือแคลอรี่",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.blueGrey,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      new Text(((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))) < 0
                                                          ? "แคลอรี่เกิน ${((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))).abs()}"
                                                          :
                                                      ((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))).toString(),
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: ((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))) < 0
                                                              ? 18
                                                              : 35,
                                                          color: ((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))) < 0
                                                              ? Colors.red
                                                              : Colors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  progressColor: ((int.parse(snapshot.data["caloriesLeft"]))-(int.parse(snapshot.data["caloriesEaten"]))) < 0
                                                      ? Colors.red
                                                      : Colors.green,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("คาร์โบไฮเดรต",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${snapshot.data!["carb"]}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.brown
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  children: [
                                                    Text("ไขมัน",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${snapshot.data!["fat"]}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.green
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  children: [
                                                    Text("โปรตีน",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${snapshot.data!["protein"]}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.redAccent
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:[
                                          Container(
                                            width: 10.0,
                                            height: 10.0,
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(width: 8,),
                                          Container(
                                            width: 10.0,
                                            height: 10.0,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF5fb27c),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          color: isVisibleBreakfast? Color(0xFF5fb27c) : Colors.white,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListTile(
                              onTap: (){
                                setState(() {
                                  isVisibleBreakfast = !isVisibleBreakfast;
                                });
                              },
                              title: Text(
                                "มื้อเช้า",
                                style: TextStyle(
                                  color: isVisibleBreakfast ? Colors.white : Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                                trailing: Wrap(
                                    spacing: 3,
                                    children: <Widget>[
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 45,
                                        color: isVisibleBreakfast ? Colors.white : Color(0xFF5fb27c),
                                      ),]
                                )
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isVisibleBreakfast
                                ? Column(
                              children: [
                                ListTile(
                                  leading: Text(""),
                                  title: Text("ชื่ออาหาร",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                  trailing: Text("จำนวนแคลอรี่",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                ),
                                for(var i in snapshot.data!["breakfast"])
                                  ListTile(
                                    leading: Icon(Icons.add),
                                    title: Text(
                                      '${i["name"]}',
                                      textScaleFactor: 1.5,
                                    ),
                                    trailing: Text(
                                      '${i["calories"]} kcal',
                                      textScaleFactor: 1.2,
                                    ),
                                  ),
                              ],
                            )
                                : Container(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Card(
                          color: isVisibleLunch ? Color(0xFF5fb27c) : Colors.white,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListTile(
                              onTap: (){
                                setState(() {
                                  isVisibleLunch = !isVisibleLunch;
                                });
                              },
                              title: Text(
                                "มื้อกลางวัน",
                                style: TextStyle(
                                    color: isVisibleLunch ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30
                                ),
                              ),
                              trailing: Wrap(
                                spacing: 3,
                                children: <Widget>[
                                  Icon(
                                  Icons.arrow_drop_down,
                                    size: 45,
                                    color: isVisibleLunch ? Colors.white : Color(0xFF5fb27c),
                                ),]
                              )
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isVisibleLunch
                                ? Column(
                              children: [
                                ListTile(
                                  leading: Text(""),
                                  title: Text("ชื่ออาหาร",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                  trailing: Text("จำนวนแคลอรี่",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                ),
                                for(var i in snapshot.data!["lunch"])
                                  ListTile(
                                    leading: Icon(Icons.add),
                                    title: Text(
                                      '${i["name"]}',
                                      textScaleFactor: 1.5,
                                    ),
                                    trailing: Text(
                                      '${i["calories"]} kcal',
                                      textScaleFactor: 1.2,
                                    ),
                                  ),
                              ],
                            )
                                : Container(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: isVisibleDinner ? Color(0xFF5fb27c) : Colors.white,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListTile(
                              onTap: (){
                                setState(() {
                                  isVisibleDinner = !isVisibleDinner;
                                });
                              },
                              title: Text(
                                "มื้อเย็น",
                                style: TextStyle(
                                    color: isVisibleDinner ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30
                                ),
                              ),
                                trailing: Wrap(
                                    spacing: 3,
                                    children: <Widget>[
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 45,
                                        color: isVisibleDinner ? Colors.white : Color(0xFF5fb27c),
                                      ),]
                                )
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isVisibleDinner
                                ? Column(
                              children: [
                                ListTile(
                                  leading: Text(""),
                                  title: Text("ชื่ออาหาร",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                  trailing: Text("จำนวนแคลอรี่",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                ),
                                for(var i in snapshot.data!["dinner"])
                                  ListTile(
                                    leading: Icon(Icons.add),
                                    title: Text(
                                      '${i["name"]}',
                                      textScaleFactor: 1.5,
                                    ),
                                    trailing: Text(
                                      '${i["calories"]} kcal',
                                      textScaleFactor: 1.2,
                                    ),
                                  ),
                              ],
                            )
                                : Container(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: isVisibleSnack ? Color(0xFF5fb27c) : Colors.white,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListTile(
                              onTap: (){
                                setState(() {
                                  isVisibleSnack = !isVisibleSnack;
                                });
                              },
                              title: Text(
                                "มื้อว่าง",
                                style: TextStyle(
                                    color: isVisibleSnack ? Colors.white : Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                                trailing: Wrap(
                                    spacing: 3,
                                    children: <Widget>[
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 45,
                                        color: isVisibleSnack ? Colors.white : Color(0xFF5fb27c),
                                      ),]
                                )
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isVisibleSnack
                                ? Column(
                              children: [
                                ListTile(
                                  leading: Text(""),
                                  title: Text("ชื่ออาหาร",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                  trailing: Text("จำนวนแคลอรี่",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                ),
                                for(var i in snapshot.data!["snack"])
                                  if (snapshot.hasData)
                                    ListTile(
                                      leading: Icon(Icons.add),
                                      title: Text(
                                        '${i["name"]}',
                                        textScaleFactor: 1.5,
                                      ),
                                      trailing: Text(
                                        '${i["calories"]} kcal',
                                        textScaleFactor: 1.2,
                                      ),
                                    ),
                              ],
                            )
                                : Container(),
                          ],
                        ),
                        const SizedBox(
                          height: 65,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
