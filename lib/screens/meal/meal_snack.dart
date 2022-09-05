import 'package:calories_counter_project/forms/updateForm/UpdateBarcode.dart';
import 'package:calories_counter_project/models/Barcode.dart';
import 'package:calories_counter_project/screens/meal/meal_breakfast.dart';
import 'package:calories_counter_project/screens/meal/meal_dinner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class mealSnack extends StatefulWidget {
  final DateTime date;
  const mealSnack({Key? key,required this.date}) : super(key: key);

  @override
  State<mealSnack> createState() => _mealSnackState(date);
}

class _mealSnackState extends State<mealSnack> {

  final DateTime date;
  _mealSnackState(this.date);

  final formKey = GlobalKey<FormState>();
  Barcode myBarcode = Barcode(name: "",barcode: "",calories: "",fat: "",protein: "",carbohydrate: "",sodium: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _barcodeCollection = FirebaseFirestore.instance.collection("BARCODES_UID_${FirebaseAuth.instance.currentUser!.uid}");

  int page = 3;

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
                      return mealDinner(date: date,);
                    }));
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded)
              ),
              Text(
                "มื้อว่าง",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              IconButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return mealBreakfast(date: date,);
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
                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFF5fb27c),
                            foregroundColor: Colors.white,
                            radius: 30,
                            backgroundImage: NetworkImage(
                                "https://cdn.icon-icons.com/icons2/1526/PNG/512/barcodescanning_106580.png"
                            ),
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
                                          /*FirebaseFirestore.instance
                                              .collection("BARCODES_UID_${FirebaseAuth.instance.currentUser!.uid}")
                                              .doc(document.id)
                                              .delete();*/
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
