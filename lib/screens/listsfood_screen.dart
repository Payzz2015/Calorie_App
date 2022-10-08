import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {

  /*void documentsLoopFromFirestore() {
    FirebaseFirestore.instance.collection("list_foods").doc("Standard").collection("ธัญพืช").get().then(
          (value) {
        value.docs.forEach(
              (result) {
            FirebaseFirestore.instance.collection("list_foods").doc("Standard").collection('Cereals and their products').doc(result.data()["name"].toString())
                .set(
              result.data(),
            );
          },
        );
      },
    );
  }*/

  TextEditingController name = new TextEditingController();
  TextEditingController calories = new TextEditingController();
  TextEditingController protein = new TextEditingController();
  TextEditingController fat = new TextEditingController();
  TextEditingController carbohydrate = new TextEditingController();
  TextEditingController sodium = new TextEditingController();
  TextEditingController sugars = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5fb27c),
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "รายการอาหาร",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                hintText: "name"
              ),

            ),
            TextFormField(
              controller: calories,
              decoration: InputDecoration(
                  hintText: "calories"
              ),
            ),
            TextFormField(
              controller: protein,
              decoration: InputDecoration(
                  hintText: "protein"
              ),
            ),
            TextFormField(
              controller: fat,
              decoration: InputDecoration(
                  hintText: "fat"
              ),
            ),
            TextFormField(
              controller: carbohydrate,
              decoration: InputDecoration(
                  hintText: "carbohydrate"
              ),
            ),
            TextFormField(
              controller: sodium,
              decoration: InputDecoration(
                  hintText: "sodium",
              ),
            ),
            /*TextFormField(
              controller: sugars,
              decoration: InputDecoration(
                  hintText: "sugars"
              ),
            ),*/
            IconButton(
              onPressed: (){
                Map <String,dynamic> data = {
                  "name":name.text,
                  "calories":calories.text,
                  "protein":protein.text,
                  "fat": fat.text,
                  "carbohydrate": carbohydrate.text,
                  "sodium": sodium.text,
                  /*"sugars": sugars.text*/
                };
                FirebaseFirestore.instance.collection("list_foods")
                    .doc("Standard")
                    .collection('Starchy roots, tubers and their products')
                    .doc(name.text)
                    .set(data);
                name.clear();
                calories.clear();
                protein.clear();
                fat.clear();
                carbohydrate.clear();
                sodium.clear();
                /*sugars.clear();*/
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
