import 'package:calories_counter_project/models/Food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormFood extends StatefulWidget {
  const FormFood({Key? key}) : super(key: key);

  @override
  State<FormFood> createState() => _FormFoodState();
}

class _FormFoodState extends State<FormFood> {

  final formKey = GlobalKey<FormState>();
  Food myFood = Food(name: "",calories: "",fat: "",protein: "",carbohydrate: "",sodium: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _foodCollection = FirebaseFirestore.instance.collection("FOODS_UID_${FirebaseAuth.instance.currentUser!.uid}");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: const Color(0xFF5fb27c),
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  "Error",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color(0xFF5fb27c),
                  ),
                ),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: const Color(0xFF5fb27c),
                elevation: 0,
                centerTitle: true,
                title: const Text(
                  "บันทึกข้อมูลอาหาร",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color(0xFF5fb27c),
                  ),
                ),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            autofocus: false,
                            keyboardType: TextInputType.name,
                            validator:
                            RequiredValidator(errorText: "กรุณาป้อนชื่ออาหาร"),
                            onSaved: (String? name) {
                              myFood.name = name!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              prefixIcon: const Icon(Icons.fastfood),
                              hintText: "ชื่อ*",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "กรุณาป้อนแคลอรี่";
                              } else if (int.parse(value) < 1) {
                                return "กรุณาป้อนแคลอรี่มากกว่ากว่า 1";
                              }
                              else if (int.parse(value) > 99999) {
                                return "กรุณาป้อนแคลอรี่ได้ไม่เกิน 99999";
                              }
                              return null;
                            },
                            onSaved: (String? calories) {
                              myFood.calories = calories!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "แคลอรี่*",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? fat) {
                              myFood.fat = fat!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "ไขมัน",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? protein) {
                              myFood.protein = protein!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "โปรตีน",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? carbohydrate) {
                              myFood.carbohydrate = carbohydrate!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "คาร์โบไฮเดรต",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? sodium) {
                              myFood.sodium = sodium!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "โซเดียม",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF5fb27c),
                            child: MaterialButton(
                              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await _foodCollection.doc(myFood.name).set({
                                    "name": myFood.name,
                                    "calories": myFood.calories,
                                    "fat": myFood.fat,
                                    "protein": myFood.protein,
                                    "carbohydrate": myFood.carbohydrate,
                                    "sodium": myFood.sodium
                                  });
                                  formKey.currentState!.reset();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text(
                                "บันทึก",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}