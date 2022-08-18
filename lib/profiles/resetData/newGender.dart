import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/resetData/newAge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class newDataGender extends StatefulWidget {
  const newDataGender({Key? key}) : super(key: key);

  @override
  State<newDataGender> createState() => _newDataGenderState();
}

class _newDataGenderState extends State<newDataGender> {

  final formKey = GlobalKey<FormState>();



  Users userData = Users(
    gender: "",
  );

  dataNavigation(BuildContext context) {
    Users users = Users(
        gender: userData.gender
    );
    if (formKey.currentState != null && formKey.currentState!.validate() && selectorGender != 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => newDataAge(user: users),
        ),
      );
    } else {
      return;
    }
  }

  int selectorGender = 0;

  @override
  Widget build(BuildContext context) {
    bool useKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "เลือกเพศของคุณ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          userData = Users(
                            gender: "ชาย",
                          );
                          selectorGender = 1;
                        },),
                    child: Container(
                      height: 150,
                      width: 150,
                      color: selectorGender == 1 ? Color(0xFF5fb27c) : Color(0xFFE4E6EA),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.man_rounded,
                            color: selectorGender == 1 ? Colors.white : Colors
                                .blueGrey,
                            size: 50,
                          ),
                          Text(
                            "ชาย",
                            style: TextStyle(
                                color:
                                selectorGender == 1 ? Colors.white : Colors
                                    .blueGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          userData = Users(
                            gender: "หญิง",
                          );
                          selectorGender = 2;
                        },),
                    child: Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      color: selectorGender == 2 ? Color(0xFF5fb27c) : Color(0xFFE4E6EA),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.woman_rounded,
                            color: selectorGender == 2 ? Colors.white : Colors
                                .blueGrey,
                            size: 50,
                          ),
                          Text(
                            "หญิง",
                            style: TextStyle(
                                color:
                                selectorGender == 2 ? Colors.white : Colors
                                    .blueGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 15.0,
                    height: 15.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF5fb27c),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 25,),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 25,),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 25,),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Visibility(
                        visible: !useKeyboard,
                        child: FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Color(0xFF2f7246),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined, size: 35,),
                          onPressed: () {
                            dataNavigation(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}

