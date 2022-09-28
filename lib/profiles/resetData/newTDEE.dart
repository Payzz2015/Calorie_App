import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/resetData/confirmNewData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class newDataTDEE extends StatefulWidget {
  final Users user;
  const newDataTDEE({Key? key,required this.user}) : super(key: key);

  @override
  State<newDataTDEE> createState() => _newDataTDEEState(user);
}

class _newDataTDEEState extends State<newDataTDEE> {
  final Users user;
  _newDataTDEEState(this.user);

  final formKey = GlobalKey<FormState>();

  User? userz = FirebaseAuth.instance.currentUser;
  Users userData  = Users();
  Users usersData = Users(
    tdee: ""
  );

  late bool _isButtonDisabled;
  @override
  void initState() {
    _isButtonDisabled = true;
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(userz!.uid)
        .get()
        .then((value) {
      userData = Users.fromMap(value.data());
      setState(() {
      });
    });
  }



  dataNavigation(BuildContext context) {

    Users users = Users(
        name: userData.name,
        gender: user.gender,
        age: user.age,
        weight: user.weight,
        height: user.height,
        tdee: usersData.tdee
    );

    if (formKey.currentState != null && formKey.currentState!.validate() && selectorExercise != 0) {
      print(users.gender);
      print(userData.name);
      print(users.age);
      print(users.height);
      print(users.weight);
      print(users.tdee);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => confirmNewData(user: users),
        ),
      );
    } else {
      return;
    }
  }

  int selectorExercise = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "โปรไฟล์ของฉัน",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "การออกกำลังกาย",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          usersData = Users(
                            tdee: "1.2",
                          );
                          selectorExercise = 1;
                          _isButtonDisabled = false;
                        },),
                    child: Container(
                      height: 50,
                      width: 300,
                      color: selectorExercise == 1 ? const Color(0xFF5fb27c) : const Color(0xFFE4E6EA),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ออกกำลังกายน้อยมากหรือไม่ออกเลย",
                            style: TextStyle(
                                color:
                                selectorExercise == 1 ? Colors.white : Colors
                                    .blueGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          usersData = Users(
                            tdee: "1.375",
                          );
                          selectorExercise = 2;
                          _isButtonDisabled = false;
                        },),
                    child: Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      color: selectorExercise == 2 ? const Color(0xFF5fb27c) : const Color(0xFFE4E6EA),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ออกกำลังกาย 1-3 ครั้งต่อสัปดาห์",
                            style: TextStyle(
                                color:
                                selectorExercise == 2 ? Colors.white : Colors
                                    .blueGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          usersData = Users(
                            tdee: "1.55",
                          );
                          selectorExercise = 3;
                          _isButtonDisabled = false;
                        },),
                    child: Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      color: selectorExercise == 3 ? const Color(0xFF5fb27c) : const Color(0xFFE4E6EA),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ออกกำลังกาย 4-5 ครั้งต่อสัปดาห์",
                            style: TextStyle(
                                color:
                                selectorExercise == 3 ? Colors.white : Colors
                                    .blueGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          usersData = Users(
                            tdee: "1.7",
                          );
                          selectorExercise = 4;
                          _isButtonDisabled = false;
                        },),
                    child: Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      color: selectorExercise == 4 ? const Color(0xFF5fb27c) : const Color(0xFFE4E6EA),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ออกกำลังกาย 6-7 ครั้งต่อสัปดาห์",
                            style: TextStyle(
                                color:
                                selectorExercise == 4 ? Colors.white : Colors
                                    .blueGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          usersData = Users(
                            tdee: "1.9",
                          );
                          selectorExercise = 5;
                          _isButtonDisabled = false;
                        },),
                    child: Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.center,
                      color: selectorExercise == 5 ? const Color(0xFF5fb27c) : const Color(0xFFE4E6EA),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ออกกำลังกาย 2 ครั้งต่อวันขึ้นไป",
                            style: TextStyle(
                                color:
                                selectorExercise == 5 ? Colors.white : Colors
                                    .blueGrey,
                                fontSize: 15,
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
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 25,),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 25,),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 25,),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 25,),
                  Container(
                    width: 15.0,
                    height: 15.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5fb27c),
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
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF5fb27c),
                        child: _isButtonDisabled
                            ?
                        MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          color: Colors.grey[400],
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width - 30,
                          onPressed: () {
                          },
                          child: const Text(
                            "ถัดไป",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                            :
                        MaterialButton(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width - 30,
                          onPressed: () {
                            dataNavigation(context);
                          },
                          child: const Text(
                            "ถัดไป",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
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
