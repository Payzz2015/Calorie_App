import 'package:calories_counter_project/forms/updateForm/UpdateBarcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodBarcode extends StatelessWidget {
  const FoodBarcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("BARCODES_UID_${FirebaseAuth.instance.currentUser!.uid}").snapshots(),
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
                'ไม่มีรายการบาร์โค้ด',
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
                      }),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((document) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF5fb27c),
                          foregroundColor: Colors.white,
                          radius: 30,
                          backgroundImage: NetworkImage(
                              "https://cdn.icon-icons.com/icons2/1526/PNG/512/barcodescanning_106580.png"),
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
                                        var userBarcode = document["barcode"].toString();
                                        var userCalories = document["calories"].toString();
                                        var userFat = document["fat"].toString();
                                        var userCarb = document["carbohydrate"].toString();
                                        var userProtein = document["protein"].toString();
                                        var userSodium = document["sodium"].toString();
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return UpdateBarcode(name: userFood,barcode: userBarcode, calories: userCalories, fat: userFat, carbohydrate: userCarb, protein: userProtein, sodium: userSodium);
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
                                            .collection("BARCODES_UID_${FirebaseAuth.instance.currentUser!.uid}")
                                            .doc(document.id)
                                            .delete();
                                      },
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        trailing: Text(
                          "${document["calories"]} kcal",
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
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
