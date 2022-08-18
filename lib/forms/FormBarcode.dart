import 'package:calories_counter_project/models/Barcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Barcode myBarcode = Barcode(name: "",barcode: "",calories: "",fat: "",protein: "",carbohydrate: "",sodium: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _barcodeCollection = FirebaseFirestore.instance.collection("barcodes");


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
                              myBarcode.name = name!;
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
                            // controller: nameEditingController,
                            maxLength: 13,
                            keyboardType: TextInputType.number,
                            validator: (value){
                              RegExp regexp = new RegExp(r'\d{13}$');
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
                              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              prefixIcon: Icon(Icons.qr_code_scanner_rounded),
                              hintText: "บาร์โค้ด*",
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
                            validator:
                            RequiredValidator(errorText: "กรุณาป้อนแคลอรี่"),
                            onSaved: (String? calories) {
                              myBarcode.calories = calories!;
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
                              myBarcode.fat = fat!;
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
                              myBarcode.protein = protein!;
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
                              myBarcode.carbohydrate = carbohydrate!;
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
                            keyboardType: TextInputType.number,
                            onSaved: (String? sodium) {
                              myBarcode.sodium = sodium!;
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
                                  await _barcodeCollection.add({
                                    "name": myBarcode.name,
                                    "barcode": myBarcode.barcode,
                                    "calories": myBarcode.calories,
                                    "fat": myBarcode.fat,
                                    "protein": myBarcode.protein,
                                    "carbohydrate": myBarcode.carbohydrate,
                                    "sodium": myBarcode.sodium
                                  });
                                  // await FirebaseFirestore.instance.collection("barcodes").doc(snapshot.data!.doc["index"]).update({
                                  //   "name": myBarcode.name,
                                  //     "barcode": myBarcode.barcode,
                                  //     "calories": myBarcode.calories,
                                  //     "fat": myBarcode.fat,
                                  //     "protein": myBarcode.protein,
                                  //     "carbohydrate": myBarcode.carbohydrate,
                                  //     "sodium": myBarcode.sodium
                                  // });
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
