import 'package:calories_counter_project/screens/detail_food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {

  late Stream<QuerySnapshot> collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Cereals and their products").snapshots();

  TextEditingController name = new TextEditingController();
  TextEditingController calories = new TextEditingController();
  TextEditingController protein = new TextEditingController();
  TextEditingController fat = new TextEditingController();
  TextEditingController carbohydrate = new TextEditingController();
  TextEditingController sodium = new TextEditingController();
  TextEditingController sugars = new TextEditingController();

  int selected = 1;
  String nameSearch = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF5fb27c),
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "รายการอาหาร",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
        body: StreamBuilder(
            stream: collectionStream,
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context,index){
                          return Container(
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
                                          decoration: BoxDecoration(
                                              color: selected == 1 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Cereals and their products").snapshots();
                                                      selected = 1;
                                                    });
                                                  },
                                                  child: Text(
                                                    "Cereals and their products",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 2 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Starchy roots, tubers and their products").snapshots();
                                                      selected = 2;
                                                    });
                                                  },
                                                  child: Text(
                                                    "Starchy roots, tubers and their products",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                    textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 3 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 3;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Spices, herbs, condiments and other seasonings").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Spices, herbs and other seasonings",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 4 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 4;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Legums, nuts, seeds and their products").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Legums, nuts, seeds and their products",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 5 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 5;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Vegetables and their products").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Vegetables and their products",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 6 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 6;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Fruits and their products").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Fruits and their products",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 7 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 7;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Meat, other animals and their products").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Meat, other animals and their products",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 8 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 8;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Finfish, shellfish, other aquatic animals and their products").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Fish, other aquatic animals and their products",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 9 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 9;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Eggs and their products").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Eggs and their products",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 10 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 10;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Milk and its products").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Milk and its products",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 11 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 11;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Fats, oils and their products").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Fats, oils and their products",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 12 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 12;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Sugars, syrup and confectionery").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Sugars, syrup and confectionery",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 13 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 13;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Beverages: nonalcoholic").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Beverages: nonalcoholic",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 14 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 14;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Fast foods: franchise foods").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Fast foods: franchise foods",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 15 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 15;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Mixed foods: ready-to-eat").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Mixed foods: ready-to-eat",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                    textScaleFactor: 1.7,
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
                                          decoration: BoxDecoration(
                                              color: selected == 16 ? Color(0xFF5fb27c) : Colors.grey.shade400,
                                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selected = 16;
                                                      collectionStream = FirebaseFirestore.instance.collection('list_foods').doc("Standard").collection("Miscellaneous").snapshots();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Miscellaneous",
                                                    style: TextStyle(
                                                        color: Colors.white, fontWeight: FontWeight.bold
                                                    ),
                                                    textScaleFactor: 1.7,

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
                          );
                        }
                      ),
                      Card(
                        shadowColor: Colors.black,
                        child: TextField(
                          onChanged: (value){
                            setState(() {
                              nameSearch = value;

                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search....",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        ),
                      ),
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((QueryDocumentSnapshot document) {
                          final dynamic data = document.data();
                          if(nameSearch.isEmpty){
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return DetailFood(name: data["name"].toString(), calories: data["calories"].toString(),sugar: data["sugars"].toString(), fat: data["fat"].toString(), carbohydrate: data["carbohydrate"].toString(), protein: data["protein"].toString(), sodium: data["sodium"].toString());
                                }));
                              },
                              child: Card(
                                elevation: 1,
                                child: ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 4, 0, 0),
                                    child: Text(
                                      document["name"],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                  trailing: Text(
                                    "${document["calories"]} kcal",
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
                          if(document["name"].toString().toLowerCase().startsWith(nameSearch.toLowerCase())){
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return DetailFood(name: data["name"].toString(), calories: data["calories"].toString(),sugar: data["sugar"].toString(), fat: data["fat"].toString(), carbohydrate: data["carbohydrate"].toString(), protein: data["protein"].toString(), sodium: data["sodium"].toString());
                                }));
                              },
                              child: Card(
                                elevation: 1,
                                child: ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 4, 0, 0),
                                    child: Text(
                                      document["name"],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                  trailing: Text(
                                    "${document["calories"]} kcal",
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
                          return Container();
                        }).toList(),
                      ),
                      SizedBox(height: 40,)
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Text('Error');
              } else {
                return Center(child: CircularProgressIndicator());
              }

            }
        ),

    );
  }
}


