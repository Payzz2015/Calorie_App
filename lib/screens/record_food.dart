import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:calories_counter_project/widgets/bottombar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordFood extends StatefulWidget {
  final String name;
  final String calories;
  final String fat;
  final String carbohydrate;
  final String protein;
  final String sugar;
  final String sodium;
  const RecordFood({Key? key,required this.name,required this.calories, required this.fat, required this.carbohydrate, required this.protein,required this.sugar, required this.sodium}) : super(key: key);

  @override
  State<RecordFood> createState() => _RecordFoodState();
}

class _RecordFoodState extends State<RecordFood> {

  final TextEditingController gramController = TextEditingController(text: "100");

  final DateTime date = DateTime.now();
  final CollectionReference trackCollection =
  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("food_track");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Color(0xFF5fb27c),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.asset(
                        "assets/icons/food_icon.jpg",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("${widget.name}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),textScaleFactor: 1.5,),
                  SizedBox(height: 8,),
                  Text(
                    gramController.text.isNotEmpty ?
                    "${(int.parse(widget.calories)*(int.parse(gramController.text)/100)).toStringAsFixed(0)} kcal"
                        : "0 kcal",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5fb27c)
                    ),
                    textScaleFactor: 1.5,
                  ),
                ],
              ),
              SizedBox(height: 35,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "ข้อมูลโภชนาการ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.black
                    )
                    ,textScaleFactor: 1.5,
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "แคลอรี่",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          gramController.text.isNotEmpty ?
                          "${(int.parse(widget.calories)*(int.parse(gramController.text)/100)).toStringAsFixed(0)} kcal"
                              : "0 kcal",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "โปรตีน",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          gramController.text.isNotEmpty ?
                          "${(double.parse(widget.protein)*(int.parse(gramController.text)/100)).toStringAsFixed(2)} g"
                              : "0 g",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ไขมัน",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          gramController.text.isNotEmpty ?
                          "${(double.parse(widget.fat)*(int.parse(gramController.text)/100)).toStringAsFixed(2)} g"
                              : "0 g",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "คาร์โบไฮเดรต",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          gramController.text.isNotEmpty ?
                          "${(double.parse(widget.carbohydrate)*(int.parse(gramController.text)/100)).toStringAsFixed(2)} g"
                              : "0 g",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "โซเดียม",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          gramController.text.isNotEmpty ?
                          "${(int.parse(widget.sodium)*(int.parse(gramController.text)/100)).toStringAsFixed(0)} mg"
                              : "0 mg",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "น้ำตาล",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          gramController.text.isNotEmpty ?
                          "${(double.parse(widget.sugar)*(int.parse(gramController.text)/100)).toStringAsFixed(2)} g"
                          : "0 g",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("ใส่ขนาดมีหน่วยเป็นกรัม",style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5,),
              SizedBox(height: 5,),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  labelText: "ขนาด (กรัม)"
                ),
                controller: gramController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(height: 20,),
              Text("เลือกมื้อที่ต้องการ",style: TextStyle(fontWeight: FontWeight.bold),textScaleFactor: 1.5,),
              SizedBox(height: 5,),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF5fb27c),
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async{
                    DocumentSnapshot trackSnapshot = await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").get();
                    var foodName = widget.name.toString();
                    var foodCalories = (int.parse(widget.calories)*(int.parse(gramController.text)/100)).toStringAsFixed(0);
                    var foodFat = (double.parse(widget.fat)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodCarb = (double.parse(widget.carbohydrate)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodProtein = (double.parse(widget.protein)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodSodium = (int.parse(widget.sodium)*(int.parse(gramController.text)/100)).toStringAsFixed(0);
                    var foodSugar = (double.parse(widget.sugar)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var eatenCalories = trackSnapshot["caloriesEaten"].toString();
                    int totalCalories = int.parse(eatenCalories) + int.parse(foodCalories);
                    double fat = double.parse("0");
                    int sodium = int.parse("0");
                    double sugar = double.parse("0");
                    double protein = double.parse("0");
                    double carb = double.parse("0");
                    if(foodFat != ""){
                      fat = double.parse(trackSnapshot["fat"]) + double.parse(foodFat);
                    }
                    if(foodCarb != ""){
                      carb = double.parse(trackSnapshot["carb"]) + double.parse(foodCarb);
                    }
                    if(foodSodium != ""){
                      sodium = int.parse(trackSnapshot["sodium"]) + int.parse(foodSodium);
                    }
                    if(foodProtein != ""){
                      protein = double.parse(trackSnapshot["protein"]) + double.parse(foodProtein);
                    }
                    if(foodSugar != ""){
                      sugar = double.parse(trackSnapshot["sugar"]) + double.parse(foodSugar);
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
                    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context){
                      return const BottomBar();
                    }), (route) => false);
                  },
                  child: const Text(
                    "มื้อเช้า",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF5fb27c),
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async{
                    DocumentSnapshot trackSnapshot = await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").get();
                    var foodName = widget.name.toString();
                    var foodCalories = (int.parse(widget.calories)*(int.parse(gramController.text)/100)).toStringAsFixed(0);
                    var foodFat = (double.parse(widget.fat)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodCarb = (double.parse(widget.carbohydrate)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodProtein = (double.parse(widget.protein)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodSodium = (int.parse(widget.sodium)*(int.parse(gramController.text)/100)).toStringAsFixed(0);
                    var foodSugar = (double.parse(widget.sugar)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var eatenCalories = trackSnapshot["caloriesEaten"].toString();
                    int totalCalories = int.parse(eatenCalories) + int.parse(foodCalories);
                    double fat = double.parse("0");
                    int sodium = int.parse("0");
                    double sugar = double.parse("0");
                    double protein = double.parse("0");
                    double carb = double.parse("0");
                    if(foodFat != ""){
                      fat = double.parse(trackSnapshot["fat"]) + double.parse(foodFat);
                    }
                    if(foodCarb != ""){
                      carb = double.parse(trackSnapshot["carb"]) + double.parse(foodCarb);
                    }
                    if(foodSodium != ""){
                      sodium = int.parse(trackSnapshot["sodium"]) + int.parse(foodSodium);
                    }
                    if(foodProtein != ""){
                      protein = double.parse(trackSnapshot["protein"]) + double.parse(foodProtein);
                    }
                    if(foodSugar != ""){
                      sugar = double.parse(trackSnapshot["sugar"]) + double.parse(foodSugar);
                    }


                    if(trackSnapshot.exists){
                      await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").set(
                        {
                          "lunch": FieldValue.arrayUnion([{
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
                    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context){
                      return const BottomBar();
                    }), (route) => false);
                  },
                  child: const Text(
                    "มื้อกลางวัน",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF5fb27c),
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async{
                    DocumentSnapshot trackSnapshot = await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").get();
                    var foodName = widget.name.toString();
                    var foodCalories = (int.parse(widget.calories)*(int.parse(gramController.text)/100)).toStringAsFixed(0);
                    var foodFat = (double.parse(widget.fat)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodCarb = (double.parse(widget.carbohydrate)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodProtein = (double.parse(widget.protein)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodSodium = (int.parse(widget.sodium)*(int.parse(gramController.text)/100)).toStringAsFixed(0);
                    var foodSugar = (double.parse(widget.sugar)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var eatenCalories = trackSnapshot["caloriesEaten"].toString();
                    int totalCalories = int.parse(eatenCalories) + int.parse(foodCalories);
                    double fat = double.parse("0");
                    int sodium = int.parse("0");
                    double sugar = double.parse("0");
                    double protein = double.parse("0");
                    double carb = double.parse("0");
                    if(foodFat != ""){
                      fat = double.parse(trackSnapshot["fat"]) + double.parse(foodFat);
                    }
                    if(foodCarb != ""){
                      carb = double.parse(trackSnapshot["carb"]) + double.parse(foodCarb);
                    }
                    if(foodSodium != ""){
                      sodium = int.parse(trackSnapshot["sodium"]) + int.parse(foodSodium);
                    }
                    if(foodProtein != ""){
                      protein = double.parse(trackSnapshot["protein"]) + double.parse(foodProtein);
                    }
                    if(foodSugar != ""){
                      sugar = double.parse(trackSnapshot["sugar"]) + double.parse(foodSugar);
                    }


                    if(trackSnapshot.exists){
                      await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").set(
                        {
                          "dinner": FieldValue.arrayUnion([{
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
                    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context){
                      return const BottomBar();
                    }), (route) => false);
                  },
                  child: const Text(
                    "มื้อเย็น",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF5fb27c),
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () async{
                    DocumentSnapshot trackSnapshot = await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").get();
                    var foodName = widget.name.toString();
                    var foodCalories = (int.parse(widget.calories)*(int.parse(gramController.text)/100)).toStringAsFixed(0);
                    var foodFat = (double.parse(widget.fat)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodCarb = (double.parse(widget.carbohydrate)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodProtein = (double.parse(widget.protein)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var foodSodium = (int.parse(widget.sodium)*(int.parse(gramController.text)/100)).toStringAsFixed(0);
                    var foodSugar = (double.parse(widget.sugar)*(int.parse(gramController.text)/100)).toStringAsFixed(2);
                    var eatenCalories = trackSnapshot["caloriesEaten"].toString();
                    int totalCalories = int.parse(eatenCalories) + int.parse(foodCalories);
                    double fat = double.parse("0");
                    int sodium = int.parse("0");
                    double sugar = double.parse("0");
                    double protein = double.parse("0");
                    double carb = double.parse("0");
                    if(foodFat != ""){
                      fat = double.parse(trackSnapshot["fat"]) + double.parse(foodFat);
                    }
                    if(foodCarb != ""){
                      carb = double.parse(trackSnapshot["carb"]) + double.parse(foodCarb);
                    }
                    if(foodSodium != ""){
                      sodium = int.parse(trackSnapshot["sodium"]) + int.parse(foodSodium);
                    }
                    if(foodProtein != ""){
                      protein = double.parse(trackSnapshot["protein"]) + double.parse(foodProtein);
                    }
                    if(foodSugar != ""){
                      sugar = double.parse(trackSnapshot["sugar"]) + double.parse(foodSugar);
                    }


                    if(trackSnapshot.exists){
                      await trackCollection.doc("${date.day}-${date.month}-${date.yearInBuddhistCalendar}").set(
                        {
                          "snack": FieldValue.arrayUnion([{
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
                    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context){
                      return const BottomBar();
                    }), (route) => false);
                  },
                  child: const Text(
                    "มื้อว่าง",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}