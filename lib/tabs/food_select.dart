import 'package:calories_counter_project/forms/updateForm/UpdateFood.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodSelect extends StatelessWidget {
  const FoodSelect({Key? key}) : super(key: key);

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
                  fontSize: 20,
                  color: Color(0xFF5fb27c),
                ),
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
                    child: TextFormField(
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
                            /*child: FittedBox(
                                alignment: Alignment.center,
                                child: Text(
                                  "Food",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                            ),*/
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
                                      child: const Text("แก้ไข"),
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
                                    TextButton(
                                      child: const Text(
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

