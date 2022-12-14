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
  Food myFood = Food(name: "",calories: "",fat: "",protein: "",carbohydrate: "",sugar: "",sodium: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _foodCollection = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("foods");

  final TextEditingController fatEditingController = TextEditingController();
  final TextEditingController proteinEditingController = TextEditingController();
  final TextEditingController carbEditingController = TextEditingController();
  final TextEditingController sugarEditingController = TextEditingController();
  final TextEditingController sodiumEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color(0xFF5fb27c),
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: const Text(
                  "Error",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textScaleFactor: 1.0,
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
                backgroundColor: Color(0xFF5fb27c),
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: const Text(
                  "???????????????????????????????????????????????????",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textScaleFactor: 1.0,
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            autofocus: false,
                            keyboardType: TextInputType.name,
                            validator:
                            RequiredValidator(errorText: "??????????????????????????????????????????????????????"),
                            onSaved: (String? name) {
                              myFood.name = name!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              prefixIcon: const Icon(Icons.fastfood),
                              labelText: "????????????*",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                                return "????????????????????????????????????????????????";
                              } else if (int.parse(value) < 1) {
                                return "????????????????????????????????????????????????????????????????????? 0";
                              }
                              else if (int.parse(value) > 99999) {
                                return "?????????????????????????????????????????????????????????????????????????????? 99999";
                              }
                              return null;
                            },
                            onSaved: (String? calories) {
                              myFood.calories = calories!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixText: "kcal",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "?????????????????????*",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("??????????????????????????????????????????",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: fatEditingController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                              TextInputFormatter.withFunction((oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? fat) {
                              myFood.fat = fat!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixText: "g",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "???????????????",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: proteinEditingController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                              TextInputFormatter.withFunction((oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                                signed: false),
                            onSaved: (String? protein) {
                              myFood.protein = protein!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixText: "g",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "??????????????????",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: carbEditingController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                              TextInputFormatter.withFunction((oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? carbohydrate) {
                              myFood.carbohydrate = carbohydrate!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixText: "g",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "????????????????????????????????????",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: sodiumEditingController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? sodium) {
                              myFood.sodium = sodium!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixText: "mg",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "?????????????????????",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: sugarEditingController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                              TextInputFormatter.withFunction((oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? sugar) {
                              myFood.sugar = sugar!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              suffixText: "g",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "??????????????????",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                                    "fat": fatEditingController.text.isNotEmpty ?(double.parse(myFood.fat)).toStringAsFixed(2) : "0.00",
                                    "protein": proteinEditingController.text.isNotEmpty ?(double.parse(myFood.protein)).toStringAsFixed(2) : "0.00",
                                    "carbohydrate": carbEditingController.text.isNotEmpty ?(double.parse(myFood.carbohydrate)).toStringAsFixed(2) : "0.00",
                                    "sugar": sugarEditingController.text.isNotEmpty ?(double.parse(myFood.sugar)).toStringAsFixed(2) : "0.00",
                                    "sodium": sodiumEditingController.text.isNotEmpty ? myFood.sodium : "0"
                                  });
                                  formKey.currentState!.reset();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text(
                                "??????????????????",
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
