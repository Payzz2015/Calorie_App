import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/confirmProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class heightForm extends StatefulWidget {
  final Users user;
  const heightForm({Key? key, required this.user}) : super(key: key);

  @override
  State<heightForm> createState() => _heightFormState(user);
}

class _heightFormState extends State<heightForm> {
  final Users user;
  _heightFormState(this.user);

  final formKey = GlobalKey<FormState>();

  int height = 150;
  final TextEditingController heightController =
      TextEditingController(text: "150");

  navigationData(BuildContext context) {
    Users users = Users(
        gender: user.gender,
        age: user.age,
        weight: user.weight,
        height: heightController.text
    );
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      print("Form Validated");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => confirmProfileScreen(user: users),
        ),
      );
    } else {
      print("Form Not Validated");
      return;
    }
  }

  void _onPressMax() {
    if (height < 220) {
      setState(() {
        height = int.parse(heightController.text);
        height = height + 1;
        heightController.text = height.toString();
      });
    }
  }

  void _onPressMin() {
    if (height > 120) {
      setState(() {
        height = int.parse(heightController.text);
        height = height - 1;
        heightController.text = height.toString();
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
      body: Form(
        key: formKey,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "กรอกข้อมูลส่วนสูง",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 280,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      color: const Color(0xFF5fb27c),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "ส่วนสูง",
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
                                return "กรุณาป้อนส่วนสูง";
                              }
                              if (int.parse(value) <= 0) {
                                return "กรุณาป้อนส่วนสูงมากกว่า 0";
                              }
                              if (int.parse(value) >= 221) {
                                return "กรุณาป้อนส่วนสูงต่ำกว่า 220";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: heightController,
                            textAlign: TextAlign.center,
                            //initialValue: weightController.text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                            onSaved: (value) {
                              heightController.text = value!;
                            },
                            decoration: InputDecoration(
                              prefixIcon: MaterialButton(
                                shape: const CircleBorder(),
                                color: Colors.white,
                                padding: const EdgeInsets.all(5),
                                onPressed: _onPressMin,
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 25,
                                  color: Color(0xFF5fb27c),
                                ),
                              ),
                              suffixIcon: MaterialButton(
                                shape: const CircleBorder(),
                                color: Colors.white,
                                padding: const EdgeInsets.all(5),
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
                      Visibility(
                        visible: !useKeyboard,
                        child: FloatingActionButton(
                          heroTag: null,
                          backgroundColor: const Color(0xFF2f7246),
                          child: const Icon(
                            Icons.check,
                            size: 35,
                          ),
                          onPressed: () {
                            navigationData(context);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
