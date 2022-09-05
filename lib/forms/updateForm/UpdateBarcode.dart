import 'package:calories_counter_project/models/Barcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class UpdateBarcode extends StatefulWidget {
  final String name;
  final String barcode;
  final String calories;
  final String fat;
  final String carbohydrate;
  final String protein;
  final String sodium;
  const UpdateBarcode({Key? key,required this.name,required this.barcode,required this.calories, required this.fat, required this.carbohydrate, required this.protein, required this.sodium}) : super(key: key);

  @override
  State<UpdateBarcode> createState() => _UpdateBarcodeState();
}

class _UpdateBarcodeState extends State<UpdateBarcode> {
  final formKey = GlobalKey<FormState>();
  Barcode myBarcode = Barcode(name: "",barcode: "",calories: "",fat: "",protein: "",carbohydrate: "",sodium: "");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _barcodeCollection = FirebaseFirestore.instance.collection("BARCODES_UID_${FirebaseAuth.instance.currentUser!.uid}");

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController barcodeEditingController = TextEditingController();
  final TextEditingController caloriesEditingController = TextEditingController();
  final TextEditingController fatEditingController = TextEditingController();
  final TextEditingController proteinEditingController = TextEditingController();
  final TextEditingController carbEditingController = TextEditingController();
  final TextEditingController sodiumEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      nameEditingController.text = widget.name;
      barcodeEditingController.text = widget.barcode;
      caloriesEditingController.text = widget.calories;
      fatEditingController.text = widget.fat;
      proteinEditingController.text = widget.protein;
      carbEditingController.text = widget.carbohydrate;
      sodiumEditingController.text = widget.sodium;
    });
  }


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
                            controller: nameEditingController,
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
                            controller: barcodeEditingController,
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
                              hintText: "บาร์โค้ด*",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: caloriesEditingController,
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
                              myBarcode.calories = calories!;
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
                            controller: fatEditingController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? fat) {
                              myBarcode.fat = fat!;
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
                            controller: proteinEditingController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? protein) {
                              myBarcode.protein = protein!;
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
                            controller: carbEditingController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            onSaved: (String? carbohydrate) {
                              myBarcode.carbohydrate = carbohydrate!;
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
                            controller: sodiumEditingController,
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
                                  if(nameEditingController.text != widget.name){
                                    await _barcodeCollection.doc(myBarcode.name).set({
                                      "name": nameEditingController.text,
                                      "barcode": barcodeEditingController.text,
                                      "calories": caloriesEditingController.text,
                                      "fat": fatEditingController.text,
                                      "protein": proteinEditingController.text,
                                      "carbohydrate": carbEditingController.text,
                                      "sodium": sodiumEditingController.text
                                    }).then((value) => deleteData());
                                  }
                                  else{
                                    await _barcodeCollection.doc(myBarcode.name).set({
                                      "name": nameEditingController.text,
                                      "barcode": barcodeEditingController.text,
                                      "calories": caloriesEditingController.text,
                                      "fat": fatEditingController.text,
                                      "protein": proteinEditingController.text,
                                      "carbohydrate": carbEditingController.text,
                                      "sodium": sodiumEditingController.text
                                    });
                                  }
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
  Future<void> deleteData() async{
    return await _barcodeCollection.doc(widget.name).delete();
  }
}
