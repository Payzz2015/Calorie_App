import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
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
              fontSize: 25,
          ),
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
                  fontSize: 20,
                  color: Color(0xFF5fb27c),
                ),
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
                    fontSize: 20,
                    color: Color(0xFF5fb27c),
                  ),
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
                                      fontSize: 25,
                                      color: Colors.white
                                  ),
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
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        print("${i}");
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Color(0xFF5fb27c),
                                            foregroundColor: Colors.white,
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                "https://cdn-icons-png.flaticon.com/512/5141/5141534.png"),
                                          ),
                                          SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${i["name"]}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 4,),
                                              Text(
                                                '${i["calories"]} แคลอรี่',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
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
                                                    "carb": (int.parse(snapshot.data!["carb"])-int.parse(i["carbohydrate"])).toString(),
                                                    "protein": (int.parse(snapshot.data!["protein"])-int.parse(i["protein"])).toString(),
                                                    "fat": (int.parse(snapshot.data!["fat"])-int.parse(i["fat"])).toString(),
                                                  });

                                            },
                                            icon: Icon(Icons.delete)
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      fontSize: 25,
                                      color: Colors.white
                                    ),
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
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        print("${i}");
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Color(0xFF5fb27c),
                                            foregroundColor: Colors.white,
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                "https://cdn-icons-png.flaticon.com/512/5141/5141534.png"),
                                          ),
                                          SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${i["name"]}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 4,),
                                              Text(
                                                '${i["calories"]} แคลอรี่',
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
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
                                                    "carb": (int.parse(snapshot.data!["carb"])-int.parse(i["carbohydrate"])).toString(),
                                                    "protein": (int.parse(snapshot.data!["protein"])-int.parse(i["protein"])).toString(),
                                                    "fat": (int.parse(snapshot.data!["fat"])-int.parse(i["fat"])).toString(),
                                                  });
                                            },
                                            icon: Icon(Icons.delete)
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      fontSize: 25,
                                      color: Colors.white
                                  ),
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
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        print("${i}");
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Color(0xFF5fb27c),
                                            foregroundColor: Colors.white,
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                "https://cdn-icons-png.flaticon.com/512/5141/5141534.png"),
                                          ),
                                          SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${i["name"]}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 4,),
                                              Text(
                                                '${i["calories"]} แคลอรี่',
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
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
                                                    "carb": (int.parse(snapshot.data!["carb"])-int.parse(i["carbohydrate"])).toString(),
                                                    "protein": (int.parse(snapshot.data!["protein"])-int.parse(i["protein"])).toString(),
                                                    "fat": (int.parse(snapshot.data!["fat"])-int.parse(i["fat"])).toString(),
                                                  });
                                            },
                                            icon: Icon(Icons.delete)
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      fontSize: 25,
                                      color: Colors.white
                                  ),
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
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        print("${i}");
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Color(0xFF5fb27c),
                                            foregroundColor: Colors.white,
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                "https://cdn-icons-png.flaticon.com/512/5141/5141534.png"),
                                          ),
                                          SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${i["name"]}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 4,),
                                              Text(
                                                '${i["calories"]} แคลอรี่',
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
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
                                                    "carb": (int.parse(snapshot.data!["carb"])-int.parse(i["carbohydrate"])).toString(),
                                                    "protein": (int.parse(snapshot.data!["protein"])-int.parse(i["protein"])).toString(),
                                                    "fat": (int.parse(snapshot.data!["fat"])-int.parse(i["fat"])).toString(),
                                                  });
                                            },
                                            icon: Icon(Icons.delete)
                                        ),
                                      ),
                                    ),
                                  ],
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
