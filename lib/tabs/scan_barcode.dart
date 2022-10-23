import 'dart:async';
import 'package:calories_counter_project/screens/details/detail_barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ScanBarcode extends StatefulWidget {
  const ScanBarcode({Key? key}) : super(key: key);

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  String _scanBarcode = "Unknown";
  String productNotFound = "";

  String? productName;
  String? productBarcode;
  String? productCalories;

  String? productFat;
  String? productCarbohydrate;
  String? productProtein;
  String? productSugars;
  String? productSodium;

  @override
  void initState(){
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {

    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#5fb27c', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> getProduct() async {

    if(_scanBarcode != "-1"){
      ProductQueryConfiguration configuration = ProductQueryConfiguration(
          _scanBarcode,
          language: OpenFoodFactsLanguage.THAI, fields: [ProductField.ALL]);
      ProductResult result = await OpenFoodAPIClient.getProduct(configuration);

      if (result.status == 1) {
        setState(() {
          productName = result.product!.productName.toString();
          productBarcode = result.product!.barcode.toString();
          productCalories = result.product!.nutriments!.energyKcal100g.toString();

          if(result.product!.nutriments!.proteins == null){
            productProtein = "0.00";
          }
          else if (result.product!.nutriments!.proteins != null){
            productProtein = result.product!.nutriments!.proteins.toString();
          }

          if(result.product!.nutriments!.carbohydrates == null){
            productCarbohydrate = "0.00";
          }
          else if (result.product!.nutriments!.carbohydrates != null){
            productCarbohydrate = result.product!.nutriments!.carbohydrates.toString();
          }

          if(result.product!.nutriments!.fat == null){
            productFat = "0.00";
          }
          else if (result.product!.nutriments!.fat != null){
            productFat = result.product!.nutriments!.fat.toString();
          }

          if(result.product!.nutriments!.sugars == null){
            productSugars = "0.00";
          }
          else if (result.product!.nutriments!.sugars != null){
            productSugars = result.product!.nutriments!.sugars.toString();
          }

          if(result.product!.nutriments!.sodium == null){
            productSodium = "0.00";
          }
          else if (result.product!.nutriments!.sodium != null){
            productSodium = result.product!.nutriments!.sodium.toString();
          }

          Navigator.push(context, MaterialPageRoute(builder: (context){
            return DetailBarcode(
                name: productName!,
                barcode: productBarcode!,
                calories: productCalories!,
                fat: productFat!,
                carbohydrate: productCarbohydrate!,
                protein: productProtein!,
                sugar: productSugars!,
                sodium: productSodium!
            );
          }));
        });
      } else {
        Fluttertoast.showToast(
          msg: "ไม่พบรายการบาร์โค้ด\n$_scanBarcode",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 15,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent,
          gravity: ToastGravity.BOTTOM_LEFT,
        );
      }
    }
    else if(_scanBarcode != "Unknown"){
      ProductQueryConfiguration configuration = ProductQueryConfiguration(
          _scanBarcode,
          language: OpenFoodFactsLanguage.THAI, fields: [ProductField.ALL]);
      ProductResult result = await OpenFoodAPIClient.getProduct(configuration);

      if (result.status == 1) {
        setState(() {
          productName = result.product!.productName.toString();
          productBarcode = result.product!.barcode.toString();
          productCalories = result.product!.nutriments!.energyKcal100g.toString();
          productProtein = result.product!.nutriments!.proteins.toString();
          productCarbohydrate = result.product!.nutriments!.carbohydrates.toString();
          productFat = result.product!.nutriments!.fat.toString();
          productSugars = result.product!.nutriments!.sugars.toString();
          productSodium = result.product!.nutriments!.sodium.toString();
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return DetailBarcode(
                name: productName!,
                barcode: productBarcode!,
                calories: productCalories!,
                fat: productFat!,
                carbohydrate: productCarbohydrate!,
                protein: productProtein!,
                sugar: productSugars!,
                sodium: productSodium!
            );
          }));
        });
      } else {
        Fluttertoast.showToast(
            msg: "ไม่พบรายการบาร์โค้ด\n$_scanBarcode",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 15,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent,
          gravity: ToastGravity.BOTTOM_LEFT,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text('ผลลัพธ์',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text("${_scanBarcode}",style: TextStyle(
                      fontSize: 20,color: Color(0xFF5fb27c)),),
                  SizedBox(height: 25,),
                  _scanBarcode != "-1" && _scanBarcode != "Unknown" ? ElevatedButton(
                    onPressed: () => getProduct(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF5fb27c)),
                    ),
                    child: Text('บันทึกโภชนาการ',style: TextStyle(fontWeight: FontWeight.bold),),
                  ) : Container(),
                ])
        ),
      floatingActionButton: FloatingActionButton(
        heroTag: "barcode",
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: Color(0xFF5fb27c),
        foregroundColor: Colors.white,
        child: const Icon(Icons.qr_code_rounded),
        onPressed: () => scanBarcodeNormal(),
      ),
    );
  }
}
