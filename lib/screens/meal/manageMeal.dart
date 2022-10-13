import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:calories_counter_project/screens/detail_food.dart';
import 'package:calories_counter_project/screens/manage_detail_food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ManageMeal extends StatefulWidget {
  final DateTime date;
  const ManageMeal({Key? key, required this.date}) : super(key: key);

  @override
  State<ManageMeal> createState() => _ManageMealState(date);
}

class _ManageMealState extends State<ManageMeal> {

  final DateTime date;
  _ManageMealState(this.date);

  String _dateFormatter(DateTime tm) {
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
    return "${tm.day} $month ${tm.yearInBuddhistCalendar}";
  }

  int lengthMeal = 0;
  int fatBreakfast = 0;
  int proteinBreakfast = 0;
  int carbBreakfast = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF5fb27c),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          _dateFormatter(date),
          style: TextStyle(
              fontWeight: FontWeight.bold,
          ),textScaleFactor: 1.5,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("food_track").doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").snapshots(),
        builder: (context, AsyncSnapshot snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'ไม่มีการบันทึกรายการอาหารของวันนี้',
                style: TextStyle(
                  color: Color(0xFF5fb27c),
                ),
                textScaleFactor: 1.0,
              ),
            );
          }
          if (snapshot.hasData) {
            lengthMeal = snapshot.data!["breakfast"].length +
                snapshot.data!["lunch"].length +
                snapshot.data!["dinner"].length +
                snapshot.data!["snack"].length;
            if(lengthMeal == 0){
              return Center(
                child: Text(
                  'ไม่มีการบันทึกรายการอาหารของวันนี้',
                  style: TextStyle(
                    color: Color(0xFF5fb27c),
                  ),textScaleFactor: 1.0,
                ),
              );
            }
            else{
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    snapshot.data!["breakfast"].length == 0
                        ? Container() : Column(
                      children: [
                        Container(
                          color: Color(0xFF699de1),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "มื้อเช้า",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                  textScaleFactor: 1.5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        for(var i in snapshot.data!["breakfast"])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Card(
                              elevation: 2,
                              shadowColor: Colors.grey.shade200,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    var userFood = i["name"].toString();
                                    var userCalories = i["calories"].toString();
                                    var userFat = i["fat"].toString();
                                    var userCarb = i["carbohydrate"].toString();
                                    var userProtein = i["protein"].toString();
                                    var userSugar = i["sugar"].toString();
                                    var userSodium = i["sodium"].toString();
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return ManageDetailFood(name: userFood, calories: userCalories,sugar: userSugar, fat: userFat, carbohydrate: userCarb, protein: userProtein, sodium: userSodium);
                                    }));
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Color(0xFF5fb27c),
                                      foregroundColor: Colors.white,
                                      radius: 25,
                                      backgroundImage: AssetImage("assets/icons/food_icon.jpg"),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                          '${i["name"]}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          textScaleFactor: 1.0,
                                        ),
                                    ),
                                    subtitle: Text(
                                      '${i["calories"]} แคลอรี่',
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                        textScaleFactor: 1.0,
                                    ),
                                    trailing: CircleAvatar(
                                      radius: 23.5,
                                      backgroundColor: Colors.black26,
                                      //Color(0xffFDCF09),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        child: IconButton(
                                            onPressed: () async{
                                              var val= [];
                                              val.add(i);
                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                                  .collection("food_track")
                                                  .doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}")
                                                  .update({
                                                "breakfast": FieldValue.arrayRemove(val),
                                                "caloriesEaten": (int.parse(snapshot.data!["caloriesEaten"])-int.parse(i["calories"])).toString(),
                                                "carb": (double.parse(snapshot.data!["carb"])-double.parse(i["carbohydrate"])).toStringAsFixed(2),
                                                "protein": (double.parse(snapshot.data!["protein"])-double.parse(i["protein"])).toStringAsFixed(2),
                                                "fat": (double.parse(snapshot.data!["fat"])-double.parse(i["fat"])).toStringAsFixed(2),
                                                "sodium": (int.parse(snapshot.data!["sodium"])-int.parse(i["sodium"])).toString(),
                                                "sugar": (double.parse(snapshot.data!["sugar"])-double.parse(i["sugar"])).toStringAsFixed(2),
                                              });

                                            },
                                            icon: Icon(Icons.delete)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    snapshot.data!["lunch"].length == 0
                        ? Container() :
                    Column(
                        children: [
                          Container(
                            color: Color(0xFF699de1),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10,bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "มื้อกลางวัน",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                    textScaleFactor: 1.5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          for(var i in snapshot.data!["lunch"])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Card(
                                elevation: 2,
                                shadowColor: Colors.grey.shade200,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                  ),
                                  child:
                                  GestureDetector(
                                    onTap: (){
                                      var userFood = i["name"].toString();
                                      var userCalories = i["calories"].toString();
                                      var userFat = i["fat"].toString();
                                      var userCarb = i["carbohydrate"].toString();
                                      var userProtein = i["protein"].toString();
                                      var userSugar = i["sugar"].toString();
                                      var userSodium = i["sodium"].toString();
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return ManageDetailFood(name: userFood, calories: userCalories,sugar: userSugar, fat: userFat, carbohydrate: userCarb, protein: userProtein, sodium: userSodium);
                                      }));
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Color(0xFF5fb27c),
                                        foregroundColor: Colors.white,
                                        radius: 25,
                                        backgroundImage: AssetImage("assets/icons/food_icon.jpg"),
                                      ),
                                      title: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          '${i["name"]}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          textScaleFactor: 1.0,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${i["calories"]} แคลอรี่',
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                        textScaleFactor: 1.0,
                                      ),
                                      trailing: CircleAvatar(
                                        radius: 23.5,
                                        backgroundColor: Colors.black26,
                                        //Color(0xffFDCF09),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black,
                                          child: IconButton(
                                              onPressed: () async{
                                                var val= [];
                                                val.add(i);
                                                await FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                                    .collection("food_track")
                                                    .doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}")
                                                    .update({
                                                  "lunch": FieldValue.arrayRemove(val),
                                                  "caloriesEaten": (int.parse(snapshot.data!["caloriesEaten"])-int.parse(i["calories"])).toString(),
                                                  "carb": (double.parse(snapshot.data!["carb"])-double.parse(i["carbohydrate"])).toStringAsFixed(2),
                                                  "protein": (double.parse(snapshot.data!["protein"])-double.parse(i["protein"])).toStringAsFixed(2),
                                                  "fat": (double.parse(snapshot.data!["fat"])-double.parse(i["fat"])).toStringAsFixed(2),
                                                  "sodium": (int.parse(snapshot.data!["sodium"])-int.parse(i["sodium"])).toString(),
                                                  "sugar": (double.parse(snapshot.data!["sugar"])-double.parse(i["sugar"])).toStringAsFixed(2),
                                                });

                                              },
                                              icon: Icon(Icons.delete)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    snapshot.data!["dinner"].length == 0
                        ? Container() : Column(
                      children: [
                        Container(
                          color: Color(0xFF699de1),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "มื้อเย็น",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                  textScaleFactor: 1.5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        for(var i in snapshot.data!["dinner"])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Card(
                              elevation: 2,
                              shadowColor: Colors.grey.shade200,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    var userFood = i["name"].toString();
                                    var userCalories = i["calories"].toString();
                                    var userFat = i["fat"].toString();
                                    var userCarb = i["carbohydrate"].toString();
                                    var userProtein = i["protein"].toString();
                                    var userSugar = i["sugar"].toString();
                                    var userSodium = i["sodium"].toString();
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return ManageDetailFood(name: userFood, calories: userCalories,sugar: userSugar, fat: userFat, carbohydrate: userCarb, protein: userProtein, sodium: userSodium);
                                    }));
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Color(0xFF5fb27c),
                                      foregroundColor: Colors.white,
                                      radius: 25,
                                      backgroundImage: AssetImage("assets/icons/food_icon.jpg"),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        '${i["name"]}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textScaleFactor: 1.0,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${i["calories"]} แคลอรี่',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                      textScaleFactor: 1.0,
                                    ),
                                    trailing: CircleAvatar(
                                      radius: 23.5,
                                      backgroundColor: Colors.black26,
                                      //Color(0xffFDCF09),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        child: IconButton(
                                            onPressed: () async{
                                              var val= [];
                                              val.add(i);
                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                                  .collection("food_track")
                                                  .doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}")
                                                  .update({
                                                "dinner": FieldValue.arrayRemove(val),
                                                "caloriesEaten": (int.parse(snapshot.data!["caloriesEaten"])-int.parse(i["calories"])).toString(),
                                                "carb": (double.parse(snapshot.data!["carb"])-double.parse(i["carbohydrate"])).toStringAsFixed(2),
                                                "protein": (double.parse(snapshot.data!["protein"])-double.parse(i["protein"])).toStringAsFixed(2),
                                                "fat": (double.parse(snapshot.data!["fat"])-double.parse(i["fat"])).toStringAsFixed(2),
                                                "sodium": (int.parse(snapshot.data!["sodium"])-int.parse(i["sodium"])).toString(),
                                                "sugar": (double.parse(snapshot.data!["sugar"])-double.parse(i["sugar"])).toStringAsFixed(2),
                                              });

                                            },
                                            icon: Icon(Icons.delete)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    snapshot.data!["snack"].length == 0
                        ? Container() : Column(
                      children: [
                        Container(
                          color: Color(0xFF699de1),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10,bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "มื้อว่าง",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                  textScaleFactor: 1.5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        for(var i in snapshot.data!["snack"])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Card(
                              elevation: 2,
                              shadowColor: Colors.grey.shade200,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    var userFood = i["name"].toString();
                                    var userCalories = i["calories"].toString();
                                    var userFat = i["fat"].toString();
                                    var userCarb = i["carbohydrate"].toString();
                                    var userProtein = i["protein"].toString();
                                    var userSugar = i["sugar"].toString();
                                    var userSodium = i["sodium"].toString();
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return ManageDetailFood(name: userFood, calories: userCalories,sugar: userSugar, fat: userFat, carbohydrate: userCarb, protein: userProtein, sodium: userSodium);
                                    }));
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Color(0xFF5fb27c),
                                      foregroundColor: Colors.white,
                                      radius: 25,
                                      backgroundImage: AssetImage("assets/icons/food_icon.jpg"),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        '${i["name"]}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textScaleFactor: 1.0,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${i["calories"]} แคลอรี่',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                      textScaleFactor: 1.0,
                                    ),
                                    trailing: CircleAvatar(
                                      radius: 23.5,
                                      backgroundColor: Colors.black26,
                                      //Color(0xffFDCF09),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        child: IconButton(
                                            onPressed: () async{
                                              var val= [];
                                              val.add(i);
                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                                  .collection("food_track")
                                                  .doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}")
                                                  .update({
                                                "snack": FieldValue.arrayRemove(val),
                                                "caloriesEaten": (int.parse(snapshot.data!["caloriesEaten"])-int.parse(i["calories"])).toString(),
                                                "carb": (double.parse(snapshot.data!["carb"])-double.parse(i["carbohydrate"])).toStringAsFixed(2),
                                                "protein": (double.parse(snapshot.data!["protein"])-double.parse(i["protein"])).toStringAsFixed(2),
                                                "fat": (double.parse(snapshot.data!["fat"])-double.parse(i["fat"])).toStringAsFixed(2),
                                                "sodium": (int.parse(snapshot.data!["sodium"])-int.parse(i["sodium"])).toString(),
                                                "sugar": (double.parse(snapshot.data!["sugar"])-double.parse(i["sugar"])).toStringAsFixed(2),
                                              });

                                            },
                                            icon: Icon(Icons.delete)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
