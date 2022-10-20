import 'package:calories_counter_project/models/Barcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormBarcode extends StatefulWidget {
  const FormBarcode({Key? key}) : super(key: key);

  @override
  State<FormBarcode> createState() => _FormBarcodeState();
}

class _FormBarcodeState extends State<FormBarcode> {
  final formKey = GlobalKey<FormState>();
  Barcode myBarcode = Barcode(name: "",barcode: "",calories: "",fat: "",protein: "",carbohydrate: "",sodium: "",sugar: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _barcodeCollection = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("barcodes");

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
                    fontSize: 30,
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
                backgroundColor: Color(0xFF5fb27c),
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: const Text(
                  "บันทึกข้อมูลอาหาร",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              body: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                              myBarcode.name = name!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              prefixIcon: const Icon(Icons.fastfood),
                              labelText: "ชื่อ*",
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
                            maxLength: 13,
                            keyboardType: TextInputType.number,
                            validator: (value){
                              RegExp regexp = RegExp(r'\d{13}$');
                              if(value!.isEmpty){
                                return ("กรุณาป้อนบาร์โค้ด");
                              }
                              if(!regexp.hasMatch(value)){
                                return ("กรุณากรอกบาร์โค้ดให้ครบ 13 ตัว");
                              }
                              return null;
                            },
                            onSaved: (String? barcode) {
                              myBarcode.barcode = barcode!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              prefixIcon: const Icon(Icons.qr_code_scanner_rounded),
                              labelText: "บาร์โค้ด*",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
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
                                return "กรุณาป้อนแคลอรี่มากกว่า 0";
                              }
                              else if (int.parse(value) > 99999) {
                                return "กรุณาป้อนแคลอรี่ได้ไม่เกิน 99999";
                              }
                              return null;
                            },
                            onSaved: (String? calories) {
                              myBarcode.calories = calories!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixText: "kcal",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "แคลอรี่*",
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
                              Text("ข้อมูลโภชนาการ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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
                              myBarcode.fat = fat!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixText: "g",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "ไขมัน",
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
                              myBarcode.protein = protein!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixText: "g",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "โปรตีน",
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
                              myBarcode.carbohydrate = carbohydrate!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixText: "g",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "คาร์โบไฮเดรต",
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
                              myBarcode.sodium = sodium!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixText: "mg",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "โซเดียม",
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
                              myBarcode.sugar = sugar!;
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              suffixText: "g",
                              suffixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: "น้ำตาล",
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
                                  await _barcodeCollection.doc(myBarcode.barcode).set({
                                    "name": myBarcode.name,
                                    "barcode": myBarcode.barcode,
                                    "calories": myBarcode.calories,
                                    "fat": fatEditingController.text.isNotEmpty ?(double.parse(myBarcode.fat)).toStringAsFixed(2) : "0.00",
                                    "protein": proteinEditingController.text.isNotEmpty ?(double.parse(myBarcode.protein)).toStringAsFixed(2) : "0.00",
                                    "carbohydrate": carbEditingController.text.isNotEmpty ?(double.parse(myBarcode.carbohydrate)).toStringAsFixed(2) : "0.00",
                                    "sugar": sugarEditingController.text.isNotEmpty ?(double.parse(myBarcode.sugar)).toStringAsFixed(2) : "0.00",
                                    "sodium": sodiumEditingController.text.isNotEmpty ? myBarcode.sodium : "0"
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
