import 'dart:async';

import 'package:calories_counter_project/screens/detail_barcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanBarcode extends StatefulWidget {
  const ScanBarcode({Key? key}) : super(key: key);

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormalZ() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('สแกนบาร์โค้ด',style: TextStyle(fontWeight: FontWeight.bold),),
          backgroundColor: Color(0xFF5fb27c),
          foregroundColor: Colors.white,
        ),
        body: Container(
            alignment: Alignment.center,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => scanBarcodeNormal(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF5fb27c)),
                      ),/*ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5fb27c),
                      ),*/
                      child: Text('เริ่มแสกนยาร์โค้ด',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Text('Scan result : $_scanBarcode\n',
                      style: TextStyle(fontSize: 20)),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("barcodes").doc(_scanBarcode).snapshots(),
                        builder: (context,AsyncSnapshot snapshot){
                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return const Center(
                              // child: CircularProgressIndicator(),
                            );
                          }
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return DetailBarcode(name: snapshot.data!["name"].toString(), calories: snapshot.data!["calories"].toString(),sugar: snapshot.data!["sugar"].toString(), fat: snapshot.data!["fat"].toString(), carbohydrate: snapshot.data!["carbohydrate"].toString(), protein: snapshot.data!["protein"].toString(), sodium: snapshot.data!["sodium"].toString(), barcode: snapshot.data!["barcode"].toString(),);
                              }));
                            },
                            child: Card(
                              elevation: 1,
                              child: ListTile(
                                title: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 4, 0, 0),
                                  child: Text(
                                    snapshot.data!["name"],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),
                                    textScaleFactor: 1,
                                  ),
                                ),
                                trailing: Text(
                                  "${snapshot.data!["calories"]} kcal",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ])));
  }
}
