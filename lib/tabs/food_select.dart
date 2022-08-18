import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodSelect extends StatelessWidget {
  const FoodSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("foods").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Color(0xFF5fb27c),
            ));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'ไม่มีรายการอาหาร',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF5fb27c),
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          child: Card(
                            color: Color(0xFF5fb27c),
                            child: Center(
                              child: Text(
                                "${snapshot.data!.docs.length} รายการ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((document) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF5fb27c),
                          foregroundColor: Colors.white,
                          radius: 30,
                          backgroundImage: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/5141/5141534.png"),
                          /*child: FittedBox(
                              alignment: Alignment.center,
                              child: Text(
                                "Food",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                          ),*/
                        ),
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                          child: Text(
                            document["name"],
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                TextButton(
                                  child: Text("แก้ไข"),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: Text(
                                    "ลบ",
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("foods")
                                        .doc(document.id)
                                        .delete();
                                  },
                                ),
                              ],
                            ))
                          ],
                        ),
                        trailing: Text(
                          "${document["calories"]} kcal",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
