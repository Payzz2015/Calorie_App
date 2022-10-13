import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {

  double max = 6;
  double min = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF5fb27c),
        centerTitle: true,
        title: Text(
          "สถิติ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 25,right: 25,bottom: 25,left: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("food_track")
                    .orderBy("day", descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
                  final List<ChartData> chartData = [];
                  if(snapshot.hasData){
                    for (var element in snapshot.data!.docs) {
                      chartData.add(ChartData((element.data()["day"]).toString(), int.parse(element.data()["caloriesEaten"]), int.parse(element.data()["weight"]), double.parse(element.data()["carb"]), double.parse(element.data()["protein"]), double.parse(element.data()["fat"])));
                    }


                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        chartData.length - min > 7 ? IconButton(
                                onPressed: (){

                                  setState(() {
                                    max += 1;
                                    min += 1;
                                  });

                                },
                                icon: Icon(Icons.arrow_back_ios_rounded)
                            ) : Container(),
                            Text(chartData.length > 7 ?
                              "7 Days" : "${chartData.length} Days",
                              style: (TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),),
                            min == 0 ? Container() : IconButton(
                                onPressed: (){
                                  setState(() {
                                    max -= 1;
                                    min -= 1;
                                  });

                                }, icon: Icon(Icons.arrow_forward_ios_rounded)
                            ),
                          ],
                        ),
                        SfCartesianChart(
                          isTransposed: true,
                          primaryXAxis: CategoryAxis(
                            maximum: chartData.length > 7 ? max : chartData.length.toDouble()-1,
                            minimum: chartData.length > 7 ? min : 0,
                          ),
                          primaryYAxis: NumericAxis(
                            labelAlignment: LabelAlignment.center
                          ),
                          series: <ChartSeries>[
                            StackedColumnSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData ch,_)=> ch.date,
                              yValueMapper: (ChartData ch,_)=> ch.weight,
                            ),
                            StackedColumnSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData ch,_)=> ch.date,
                              yValueMapper: (ChartData ch,_)=> ch.caloriesEaten,
                            ),
                            StackedColumnSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData ch,_)=> ch.date,
                              yValueMapper: (ChartData ch,_)=> ch.carb,
                            ),
                            StackedColumnSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData ch,_)=> ch.date,
                              yValueMapper: (ChartData ch,_)=> ch.protein,
                            ),
                            StackedColumnSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData ch,_)=> ch.date,
                              yValueMapper: (ChartData ch,_)=> ch.fat,
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        color: Color(0xFF4b87b9),
                                        height: 25,
                                        width: 25,
                                      ),
                                      Text(
                                        "น้ำหนัก",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        textScaleFactor: 1.0,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        color: Color(0xFFc06c84),
                                        height: 25,
                                        width: 25,
                                      ),
                                      Text(
                                        "แคลอรี่",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        textScaleFactor: 1.0,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        color: Color(0xFFf67280),
                                        height: 25,
                                        width: 25,
                                      ),
                                      Text(
                                        "คาร์โบไฮเดรต",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        textScaleFactor: 1.0,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        color: Color(0xFFf8b195),
                                        height: 25,
                                        width: 25,
                                      ),
                                      Text(
                                        "โปรตีน",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        textScaleFactor: 1.0,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        color: Color(0xFF74b49b),
                                        height: 25,
                                        width: 25,
                                      ),
                                      Text(
                                        "ไขมัน",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        textScaleFactor: 1.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return Container(
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData{
  final String date;
  final int caloriesEaten;
  final int weight;
  final double carb;
  final double protein;
  final double fat;
  ChartData(this.date, this.caloriesEaten, this.weight, this.carb, this.protein, this.fat);
}