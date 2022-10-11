import 'package:flutter/material.dart';

class FF extends StatefulWidget {
  const FF({Key? key}) : super(key: key);

  @override
  State<FF> createState() => _FFState();
}

class _FFState extends State<FF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text("Test List Food", style: TextStyle(color: Colors.green),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  children: <Widget>[
                    //1
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                setState(() {

                                });
                              },
                              child: Text(
                                "Cereals and their products",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //2
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  print("list");
                                });
                              },
                              child: Text(
                                "Starchy roots, tubers and their products",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //3
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Spices, herbs and other seasonings",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //4
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Legums, nuts, seeds and their products",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //5
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Vegetables and their products",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //6
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Fruits and their products",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //7
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Meat, other animals and their products",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //8
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Fish, other aquatic animals and their products",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //9
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Eggs and their products",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //10
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Milk and its products",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //11
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Fats, oils and their products",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //12
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Sugars, syrup and confectionery",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //13
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Beverages: nonalcoholic",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //14
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Fast foods: franchise foods",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //15
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Mixed foods: ready-to-eat",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //16
                    Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 20),
                      height: MediaQuery.of(context).size.height * 0.30 - 50,
                      decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                "Miscellaneous",
                                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}
