import 'package:calories_counter_project/screens/record_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailFood extends StatefulWidget {
  final String name;
  final String calories;
  final String fat;
  final String carbohydrate;
  final String protein;
  final String sugar;
  final String sodium;
  const DetailFood({Key? key,required this.name,required this.calories, required this.fat, required this.carbohydrate, required this.protein,required this.sugar, required this.sodium}) : super(key: key);

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
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
                        "assets/icons/food_icon.jpg",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("${widget.name}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),textScaleFactor: 1.5,),
                  SizedBox(height: 8,),
                  Text(
                    "${widget.calories} kcal" ,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5fb27c)
                    ),
                    textScaleFactor: 1.5,
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
                          "${widget.calories} kcal",
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
                        Text(widget.protein == "" ?
                        "0 g" :
                            "${widget.protein} g",
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
                        Text(widget.fat == "" ?
                        "0 g" :
                            "${widget.fat} g",
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
                        Text(widget.carbohydrate == "" ?
                        "0 g":
                            "${widget.carbohydrate} g",
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
                          widget.sodium == "" ?
                          "0 mg" :"${widget.sodium} mg",
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
                          widget.sugar == "" ?
                          "0 g" :
                          "${widget.sugar} g",
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
                      return RecordFood(name: widget.name, calories: widget.calories, fat: widget.fat, carbohydrate: widget.carbohydrate, protein: widget.protein, sugar: widget.sugar, sodium: widget.sodium);
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