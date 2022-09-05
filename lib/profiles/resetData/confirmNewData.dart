import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/widgets/bottombar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class confirmNewData extends StatefulWidget {
  final Users user;
  const confirmNewData({Key? key,required this.user}) : super(key: key);

  @override
  State<confirmNewData> createState() => _confirmNewDataState(user);
}

class _confirmNewDataState extends State<confirmNewData> {

  final formKey = GlobalKey<FormState>();

  final firebaseAuth = FirebaseAuth.instance;

  final Users user;
  _confirmNewDataState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "ยืนยันข้อมูลของคุณ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.green,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 0),
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF5fb27c),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("เพศ ",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text("${user.gender}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("อายุ ",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text("${user.age} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          const Text("ปี",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("น้ำหนัก ",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text("${user.weight} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          const Text("kg",
                            style: TextStyle(
                              fontSize: 30,
                              color:Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("ส่วนสูง ",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text("${user.height} ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          const Text("cm",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF2f7246),
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        collectDatatoFirestore();
                      }else{
                        Fluttertoast.showToast(msg: "Fail");
                      }
                    },
                    //signIn(emailController.text, passwordController.text);
                    child: const Text(
                      "ยืนยัน",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFF3F0E9),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  collectDatatoFirestore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? userAuth = firebaseAuth.currentUser;
    Users userData = Users();

    double heightM = ((double.parse(user.height!)/100) * (double.parse(user.height!)/100));
    double bmi = double.parse(user.weight!) / heightM;
    user.bmi = bmi.toStringAsFixed(1);

    if(user.gender! == "ชาย"){
      double bmr = (10*(int.parse(user.weight!)))+(6.25*(int.parse(user.height!)))-(5*(int.parse(user.age!)))+5;
      user.bmr = bmr.toStringAsFixed(0);
    }
    else if(user.gender! == "หญิง"){
      double bmr = (10*(int.parse(user.weight!)))+(6.25*(int.parse(user.height!)))-(5*(int.parse(user.age!)))-161;
      user.bmr = bmr.toStringAsFixed(0);
    }


    userData.name = user.name;
    userData.email = userAuth!.email;
    userData.uid = userAuth.uid;
    userData.gender = user.gender;
    userData.age = user.age;
    userData.weight = user.weight;
    userData.height = user.height;
    userData.bmi = user.bmi;
    userData.bmr = user.bmr;

    await firebaseFirestore.collection("users").doc(userAuth.uid).update(userData.toMap());
    Fluttertoast.showToast(msg: "ตั้งข้อมูลใหม่สำเร็จ");

    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context){
      return const BottomBar();
    }), (route) => false);
  }
}