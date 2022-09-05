import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ageForm extends StatefulWidget {
  final Users user;
  const ageForm({Key? key,required this.user}) : super(key: key);

  @override
  State<ageForm> createState() => _ageFormState(user);
}

class _ageFormState extends State<ageForm> {

  final Users user;
  _ageFormState(this.user);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int age = 0;
  TextEditingController ageController = TextEditingController(text: "0");

  navigationData(BuildContext context) {
    Users users = Users(
      gender: user.gender,
      age: ageController.text,
    );
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      print("Form Validated");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => weightForm(user: users),
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
              const Text(
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
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
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
                    width: 15.0,
                    height: 15.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5fb27c),
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
                      child: const Icon(Icons.arrow_forward_ios_rounded,size: 35,),
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
