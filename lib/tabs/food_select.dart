import 'package:calories_counter_project/forms/updateForm/UpdateFood.dart';
import 'package:calories_counter_project/screens/detail_food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodSelect extends StatefulWidget {
  const FoodSelect({Key? key}) : super(key: key);

  @override
  State<FoodSelect> createState() => _FoodSelectState();
}

class _FoodSelectState extends State<FoodSelect> {

  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
                ),textScaleFactor: 1.0,
              ),
            );
          }
          if (snapshot.hasData) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                                    fontSize: 20,
                                    color: Colors.white
                                ),
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
                        return GestureDetector(
                          onTap: (){
                            var userFood = document["name"].toString();
                            var userCalories = document["calories"].toString();
                            var userFat = document["fat"].toString();
                            var userCarb = document["carbohydrate"].toString();
                            var userProtein = document["protein"].toString();
                            var userSugar = document["sugar"].toString();
                            var userSodium = document["sodium"].toString();
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return DetailFood(name: userFood, calories: userCalories,sugar: userSugar, fat: userFat, carbohydrate: userCarb, protein: userProtein, sodium: userSodium);
                            }));
                          },
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(0xFF5fb27c),
                                foregroundColor: Colors.white,
                                radius: 30,
                                backgroundImage: AssetImage("assets/icons/food_icon.jpg"),
                              ),
                              title: Padding(
                                padding: EdgeInsets.fromLTRB(10, 4, 0, 0),
                                child: Text(
                                  document["name"],
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textScaleFactor: 1.5,
                                ),
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        TextButton(
                                          child: Text("แก้ไข"),
                                          onPressed: () {
                                            var userFood = document["name"].toString();
                                            var userCalories = document["calories"].toString();
                                            var userFat = document["fat"].toString();
                                            var userCarb = document["carbohydrate"].toString();
                                            var userProtein = document["protein"].toString();
                                            var userSugar = document["sugar"].toString();
                                            var userSodium = document["sodium"].toString();
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return UpdateFood(name: userFood, calories: userCalories, sugar: userSugar, fat: userFat, carbohydrate: userCarb, protein: userProtein, sodium: userSodium);
                                            }));

                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            "ลบ",
                                            style: TextStyle(color: Colors.redAccent),
                                          ),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                                .collection("foods")
                                                .doc(document.id)
                                                .delete();
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              trailing: Text(
                                "${document["calories"]} kcal",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                ),
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ),
                        );
                      }
                      if(document["name"].toString().toLowerCase().startsWith(name.toLowerCase())){
                        return GestureDetector(
                          onTap: (){
                            var userFood = document["name"].toString();
                            var userCalories = document["calories"].toString();
                            var userFat = document["fat"].toString();
                            var userCarb = document["carbohydrate"].toString();
                            var userProtein = document["protein"].toString();
                            var userSugar = document["sugar"].toString();
                            var userSodium = document["sodium"].toString();
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return DetailFood(name: userFood, calories: userCalories,sugar: userSugar, fat: userFat, carbohydrate: userCarb, protein: userProtein, sodium: userSodium);
                            }));
                          },
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color(0xFF5fb27c),
                                foregroundColor: Colors.white,
                                radius: 30,
                                backgroundImage: AssetImage("assets/icons/food_icon.jpg"),
                              ),
                              title: Padding(
                                padding: EdgeInsets.fromLTRB(10, 4, 0, 0),
                                child: Text(
                                  document["name"],
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textScaleFactor: 1.5,
                                ),
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        TextButton(
                                          child: Text("แก้ไข"),
                                          onPressed: () {
                                            var userFood = document["name"].toString();
                                            var userCalories = document["calories"].toString();
                                            var userFat = document["fat"].toString();
                                            var userCarb = document["carbohydrate"].toString();
                                            var userProtein = document["protein"].toString();
                                            var userSugar = document["sugar"].toString();
                                            var userSodium = document["sodium"].toString();
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return UpdateFood(name: userFood, calories: userCalories,sugar: userSugar, fat: userFat, carbohydrate: userCarb, protein: userProtein, sodium: userSodium);
                                            }));

                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            "ลบ",
                                            style: TextStyle(color: Colors.redAccent),
                                          ),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                                .collection("foods")
                                                .doc(document.id)
                                                .delete();
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              trailing: Text(
                                "${document["calories"]} kcal",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                ),
                                textScaleFactor: 1.5,
                              ),
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
