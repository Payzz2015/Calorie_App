import 'package:calories_counter_project/screens/details/record_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailBarcode extends StatefulWidget {
  final String name;
  final String barcode;
  final String calories;
  final String fat;
  final String carbohydrate;
  final String protein;
  final String sugar;
  final String sodium;
  const DetailBarcode({Key? key,required this.name,required this.barcode,required this.calories, required this.fat, required this.carbohydrate, required this.protein,required this.sugar, required this.sodium}) : super(key: key);

  @override
  State<DetailBarcode> createState() => _DetailBarcodeState();
}

class _DetailBarcodeState extends State<DetailBarcode> {

  String? caloriesFormat;
  String? fatFormat;
  String? carbohydrateFormat;
  String? proteinFormat;
  String? sugarFormat;
  String? sodiumFormat;
  @override
  void initState() {
   super.initState();
   caloriesFormat = (double.parse(widget.calories)).toStringAsFixed(0);
   fatFormat = (double.parse(widget.fat)).toStringAsFixed(2);
   carbohydrateFormat = (double.parse(widget.carbohydrate)).toStringAsFixed(2);
   proteinFormat = (double.parse(widget.protein)).toStringAsFixed(2);
   sugarFormat = (double.parse(widget.sugar)).toStringAsFixed(2);
   sodiumFormat = (((double.parse(widget.sodium)))*1000).toStringAsFixed(0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Color(0xFF5fb27c),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.asset(
                        "assets/icons/barcode_icon.jpg",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("${widget.name}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),textScaleFactor: 1.0,),
                  SizedBox(height: 8,),
                  Text(
                    "${caloriesFormat} kcal" ,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5fb27c)
                    ),
                    textScaleFactor: 1.0,
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "บาร์โค้ด : ${widget.barcode}" ,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreen
                    ),
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
              SizedBox(height: 35,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "ข้อมูลโภชนาการ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,color: Colors.black
                    )
                    ,textScaleFactor: 1.5,
                  ),
                  Text(
                    "(1 เสิร์ฟ/100 กรัม)",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5fb27c)
                    ),
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "แคลอรี่",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "${caloriesFormat} kcal",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "โปรตีน",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(proteinFormat == "" ?
                        "0 g" :
                        "${proteinFormat} g",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ไขมัน",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(fatFormat == "" ?
                        "0 g" :
                        "${fatFormat} g",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "คาร์โบไฮเดรต",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(carbohydrateFormat == "" ?
                        "0 g":
                        "${carbohydrateFormat} g",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "โซเดียม",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          sodiumFormat == "" ?
                          "0 mg" :"${sodiumFormat} mg",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.green.shade100,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "น้ำตาล",
                          style: TextStyle(
                              color: Colors.grey.shade700
                          )
                          ,textScaleFactor: 1.2,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          sugarFormat == "" ?
                          "0 g" :
                          "${sugarFormat} g",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900
                          ),
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF5fb27c),
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return RecordFood(name: widget.name, calories: caloriesFormat!, fat: widget.fat, carbohydrate: widget.carbohydrate, protein: widget.protein, sugar: widget.sugar, sodium: sodiumFormat!);
                    }));

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
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}