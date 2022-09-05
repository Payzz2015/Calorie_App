import 'package:calories_counter_project/forms/updateForm/UpdateFood.dart';
import 'package:calories_counter_project/screens/meal/meal_breakfast.dart';
import 'package:calories_counter_project/screens/meal/meal_dinner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class mealLunch extends StatefulWidget {
  final DateTime date;
  const mealLunch({Key? key,required this.date}) : super(key: key);

  @override
  State<mealLunch> createState() => _mealLunchState(date);
}

class _mealLunchState extends State<mealLunch> {

  final DateTime date;
  _mealLunchState(this.date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      return mealBreakfast(date: date,);
                    }));
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded)
              ),
              Text(
                "มื้อกลางวัน",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              IconButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return mealDinner(date: date,);
                    }));
                  },
                  icon: Icon(Icons.arrow_forward_ios_rounded)
              ),
              SizedBox(width: 40,),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("FOODS_UID_${FirebaseAuth.instance.currentUser!.uid}").snapshots(),
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
                  fontSize: 20,
                  color: Color(0xFF5fb27c),
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
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
                                "${snapshot.data!.docs.length} รายการ",
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
                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFF5fb27c),
                            foregroundColor: Colors.white,
                            radius: 30,
                            backgroundImage: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/5141/5141534.png"),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                            child: Text(
                              document["name"],
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          subtitle: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    TextButton(
                                      child: const Text("เลือก"),
                                      onPressed: () {
                                        var userFood = document["name"].toString();
                                        var userCalories = document["calories"].toString();
                                        var userFat = document["fat"].toString();
                                        var userCarb = document["carbohydrate"].toString();
                                        var userProtein = document["protein"].toString();
                                        var userSodium = document["sodium"].toString();
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return UpdateFood(name: userFood, calories: userCalories, fat: userFat, carbohydrate: userCarb, protein: userProtein, sodium: userSodium);
                                        }));

                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          trailing: Text(
                            "${document["calories"]} kcal",
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      );
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
