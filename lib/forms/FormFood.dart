import 'package:calories_counter_project/models/Food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference _foodCollection = FirebaseFirestore.instance.collection("foods");

  // final nameEditingController = new TextEditingController();
  // final caloriesEditingController = new TextEditingController();
  // final fatEditingController = new TextEditingController();
  // final proteinEditingController = new TextEditingController();
  // final carbEditingController = new TextEditingController();
  // final sodiumEditingController = new TextEditingController();

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
                foregroundColor: Color(0xFF5fb27c),
                elevation: 0,
                centerTitle: true,
                title: Text(
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
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Color(0xFF5fb27c),
                elevation: 0,
                centerTitle: true,
                title: Text(
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
                            // controller: nameEditingController,
                            keyboardType: TextInputType.name,
                            validator:
                            RequiredValidator(errorText: "กรุณาป้อนชื่ออาหาร"),
                            onSaved: (String? name) {
                              myFood.name = name!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              prefixIcon: Icon(Icons.fastfood),
                              hintText: "ชื่อ*",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            // controller: caloriesEditingController,
                            keyboardType: TextInputType.number,
                            validator:
                            RequiredValidator(errorText: "กรุณาป้อนแคลอรี่"),
                            onSaved: (String? calories) {
                              myFood.calories = calories!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "แคลอรี่*",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            /*validator:
                            RequiredValidator(errorText: "กรุณาป้อนไขมัน"),*/
                            onSaved: (String? fat) {
                              myFood.fat = fat!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "ไขมัน",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            /*validator:
                            RequiredValidator(errorText: "กรุณาป้อนโปรตีน"),*/
                            onSaved: (String? protein) {
                              myFood.protein = protein!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "โปรตีน",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            /*validator:
                            RequiredValidator(errorText: "กรุณาป้อนคาร์โบไฮเดรต"),*/
                            onSaved: (String? carbohydrate) {
                              myFood.carbohydrate = carbohydrate!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "คาร์โบไฮเดรต",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            // controller: fatEditingController,
                            keyboardType: TextInputType.number,
                            onSaved: (String? sodium) {
                              myFood.sodium = sodium!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                            color: Color(0xFF5fb27c),
                            child: MaterialButton(
                              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await _foodCollection.add({
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
                              child: Text(
                                "บันทึก",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,)
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
