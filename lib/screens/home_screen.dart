import 'package:calories_counter_project/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // User? user = FirebaseAuth.instance.currentUser!;
  // Users users = Users();

  @override
  void initState(){
    super.initState();
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user!.uid)
    //     .get()
    //     .then((value){
    //   users = Users.fromMap(value.data());
    //   setState(() {
    //
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // int ageUser = int.parse(users.age!);
    //int heightUser = int.parse(users.height!);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF5fb27c),
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text("หน้าหลัก",
            style:
            TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (conetext) {
                  return HistoryScreen();
                }));
              },
              icon: Icon(
                Icons.calendar_month_rounded,
                size: 28,
              ),
            )
          ],
        ),
        body: Center(
          child: Text(""),
        ));
  }
}
