import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:calories_counter_project/forms/updateForm/UpdateFood.dart';
import 'package:calories_counter_project/models/Day.dart';
import 'package:calories_counter_project/screens/meal/meal_lunch.dart';
import 'package:calories_counter_project/screens/meal/meal_snack.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class mealBreakfast extends StatefulWidget {
  final DateTime date;
  const mealBreakfast({Key? key,required this.date}) : super(key: key);

  @override
  State<mealBreakfast> createState() => _mealBreakfastState(date);
}

class _mealBreakfastState extends State<mealBreakfast> {

  final DateTime date;
  _mealBreakfastState(this.date);

  final CollectionReference trackCollection =
  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("food_track");

  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF5fb27c),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return mealSnack(date: date,);
                    }));
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)
              ),
              const Text(
                "มื้อเช้า",
                style: TextStyle(
                    fontWeight: FontWeight.bold),textScaleFactor: 1.0,
              ),
              IconButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return mealLunch(date: date,);
                    }));
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded)
              ),
              const SizedBox(width: 40,),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("foods").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xFF5fb27c),
                ));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'ไม่มีรายการอาหาร',
                style: TextStyle(
                  color: Color(0xFF5fb27c),
                ),
                textScaleFactor: 1.0,
              ),
            );
          }
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    shadowColor: Colors.black,
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search....",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),

                    ),
                  ),
                  ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 50,
                          child: Card(
                            color: const Color(0xFF5fb27c),
                            child: Center(
                              child: Text(
                                name.isEmpty ? "${snapshot.data!.docs.length} รายการ" : "รายการอาหารที่พบ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((document) {
                      if(name.isEmpty){
                        return Card(
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFF5fb27c),
                              foregroundColor: Colors.white,
                              radius: 30,
                              backgroundImage: AssetImage("assets/icons/food_icon.jpg"),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                              child: Text(
                                document["name"],
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),textScaleFactor: 1.5,
                              ),
                            ),
                            subtitle: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    TextButton(
                                      child: const Text("เลือก"),
                                      onPressed: () async{
                                        DocumentSnapshot trackSnapshot = await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").get();
                                        var foodName = document["name"].toString();
                                        var foodCalories = document["calories"].toString();
                                        var foodFat = document["fat"].toString();
                                        var foodCarb = document["carbohydrate"].toString();
                                        var foodProtein = document["protein"].toString();
                                        var foodSodium = document["sodium"].toString();
                                        var foodSugar = document["sugar"].toString();
                                        var eatenCalories = trackSnapshot["caloriesEaten"].toString();
                                        int totalCalories = int.parse(eatenCalories) + int.parse(foodCalories);
                                        int fat = int.parse("0");
                                        int sodium = int.parse("0");
                                        int sugar = int.parse("0");
                                        int protein = int.parse("0");
                                        int carb = int.parse("0");
                                        if(foodFat != ""){
                                          fat = int.parse(trackSnapshot["fat"]) + int.parse(foodFat);
                                        }
                                        if(foodCarb != ""){
                                          carb = int.parse(trackSnapshot["carb"]) + int.parse(foodCarb);
                                        }
                                        if(foodSodium != ""){
                                          sodium = int.parse(trackSnapshot["sodium"]) + int.parse(foodSodium);
                                        }
                                        if(foodProtein != ""){
                                          protein = int.parse(trackSnapshot["protein"]) + int.parse(foodProtein);
                                        }
                                        if(foodSugar != ""){
                                          sugar = int.parse(trackSnapshot["sugar"]) + int.parse(foodSugar);
                                        }


                                        if(trackSnapshot.exists){
                                          await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").set(
                                              {
                                                "breakfast": FieldValue.arrayUnion([{
                                                  "name": foodName,
                                                  "calories": foodCalories,
                                                  "fat": foodFat == "" ? "0" : foodFat,
                                                  "carbohydrate": foodCarb == "" ? "0" : foodCarb,
                                                  "protein": foodProtein == "" ? "0" : foodProtein,
                                                  "sodium": foodSodium == "" ? "0" : foodSodium,
                                                  "sugar": foodSugar == "" ? "0" : foodSugar,
                                                  "datetime": DateTime.now(),
                                                }]),
                                                "caloriesEaten": totalCalories.toString(),
                                                "fat": fat.toString(),
                                                "carb": carb.toString(),
                                                "protein": protein.toString(),
                                                "sodium": sodium.toString(),
                                                "sugar": sugar.toString(),
                                              },SetOptions(merge: true),
                                          );
                                        }
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                            trailing: Text(
                              "${document["calories"]} kcal",
                              style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  ),textScaleFactor: 1.0,
                            ),
                          ),
                        );
                      }
                      if(document["name"].toString().toLowerCase().startsWith(name.toLowerCase())){
                        return Card(
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFF5fb27c),
                              foregroundColor: Colors.white,
                              radius: 30,
                              backgroundImage: AssetImage("assets/icons/food_icon.jpg"),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                              child: Text(
                                document["name"],
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),textScaleFactor: 1.5,
                              ),
                            ),
                            subtitle: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    TextButton(
                                      child: const Text("เลือก"),
                                      onPressed: () async{
                                        DocumentSnapshot trackSnapshot = await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").get();
                                        var foodName = document["name"].toString();
                                        var foodCalories = document["calories"].toString();
                                        var foodFat = document["fat"].toString();
                                        var foodCarb = document["carbohydrate"].toString();
                                        var foodProtein = document["protein"].toString();
                                        var foodSodium = document["sodium"].toString();
                                        var foodSugar = document["sugar"].toString();
                                        var eatenCalories = trackSnapshot["caloriesEaten"].toString();
                                        int totalCalories = int.parse(eatenCalories) + int.parse(foodCalories);
                                        int fat = int.parse("0");
                                        int sodium = int.parse("0");
                                        int sugar = int.parse("0");
                                        int protein = int.parse("0");
                                        int carb = int.parse("0");
                                        if(foodFat != ""){
                                          fat = int.parse(trackSnapshot["fat"]) + int.parse(foodFat);
                                        }
                                        if(foodCarb != ""){
                                          carb = int.parse(trackSnapshot["carb"]) + int.parse(foodCarb);
                                        }
                                        if(foodSugar != ""){
                                          sugar = int.parse(trackSnapshot["sugar"]) + int.parse(foodSugar);
                                        }
                                        if(foodSodium != ""){
                                          sodium = int.parse(trackSnapshot["sodium"]) + int.parse(foodSodium);
                                        }
                                        if(foodProtein != ""){
                                          protein = int.parse(trackSnapshot["protein"]) + int.parse(foodProtein);
                                        }


                                        if(trackSnapshot.exists){
                                          await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").set(
                                              {
                                                "breakfast": FieldValue.arrayUnion([{
                                                  "name": foodName,
                                                  "calories": foodCalories,
                                                  "fat": foodFat,
                                                  "carbohydrate": foodCarb,
                                                  "protein": foodProtein,
                                                  "sodium": foodSodium,
                                                  "sugar": foodSugar,
                                                  "datetime": DateTime.now(),
                                                }]),
                                                "caloriesEaten": totalCalories.toString(),
                                                "fat": fat.toString(),
                                                "carb": carb.toString(),
                                                "protein": protein.toString(),
                                                "sodium": sodium.toString(),
                                                "sugar": sugar.toString(),
                                              },SetOptions(merge: true)
                                          );
                                        }
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                            trailing: Text(
                              "${document["calories"]} kcal",
                              style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  ),textScaleFactor: 1.0,
                            ),
                          ),
                        );
                      }
                      return Container();

                    }).toList(),
                  ),
                  const SizedBox(
                    height: 25,
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

}
