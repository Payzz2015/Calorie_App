import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/resetData/newWeight.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class newDataAge extends StatefulWidget {
  final Users user;
  const newDataAge({Key? key,required this.user}) : super(key: key);

  @override
  State<newDataAge> createState() => _newDataAgeState(user);
}

class _newDataAgeState extends State<newDataAge> {

  final Users user;
  _newDataAgeState(this.user);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int age = 0;
  TextEditingController ageController = TextEditingController(text: "0");

  navigationData(BuildContext context) {
    Users users = Users(
      name: user.name,
      gender: user.gender,
      age: ageController.text,
    );
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      print("Form Validated");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => newDataWeight(user: users),
        ),
      );
    } else {
      print("Not Validated");
      return;
    }
  }

  void _onPressMax() {
    if (age < 100) {
      setState(() {
        age = int.parse(ageController.text);
        age = age + 1;
        ageController.text = age.toString();
      });
    }
  }

  void _onPressMin() {
    if (age > 0) {
      setState(() {
        age = int.parse(ageController.text);
        age = age - 1;
        ageController.text = age.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool useKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
      ),
      body: //Text("${user.gender!}"),
      Form(
        key: formKey,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "กรอกข้อมูลอายุ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 280,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      color: Color(0xFF5fb27c),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "อายุ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "กรุณาป้อนอายุ";
                              }
                              if (int.parse(value) <= 0) {
                                return "กรุณาป้อนอายุมากกว่า 0";
                              }
                              if (int.parse(value) >= 101) {
                                return "กรุณาป้อนอายุต่ำกว่า 100";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              ageController.text = value!;
                            },
                            keyboardType: TextInputType.number,
                            controller: ageController,
                            textAlign: TextAlign.center,
                            //initialValue: weightController.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              prefixIcon: MaterialButton(
                                shape: CircleBorder(),
                                color: Colors.white,
                                padding: EdgeInsets.all(5),
                                onPressed: _onPressMin,
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 25,
                                  color: Color(0xFF5fb27c),
                                ),
                              ),
                              suffixIcon: MaterialButton(
                                shape: CircleBorder(),
                                color: Colors.white,
                                padding: EdgeInsets.all(5),
                                onPressed: _onPressMax,
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 25,
                                  color: Color(0xFF5fb27c),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
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
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 25,),
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
                          child: Icon(Icons.arrow_forward_ios_rounded,size: 35,),
                          onPressed: (){
                            navigationData(context);
                          },
                        ),
                      )
                    ],),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
