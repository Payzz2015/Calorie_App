import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class weightForm extends StatefulWidget {
  final Users user;
  const weightForm({Key? key,required this.user}) : super(key: key);

  @override
  State<weightForm> createState() => _weightFormState(user);
}

class _weightFormState extends State<weightForm> {

  final Users user;
  _weightFormState(this.user);

  final formKey = GlobalKey<FormState>();

  int weight = 20;
  final TextEditingController weightController =
      TextEditingController(text: "20");

  navigationData(BuildContext context) {
    Users users = Users(
      gender: user.gender,
      age: user.age,
      weight: weightController.text,
    );
    if (formKey.currentState != null && formKey.currentState!.validate()){
      print("Form Validated");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => heightForm(user: users),
        ),
      );
    } else {
      print("Form Not Validated");
      return;
    }
  }

  void _onPressMax() {
    if(weight < 150){
      setState(() {
        weight = int.parse(weightController.text);
        weight = weight + 1;
        weightController.text  = weight.toString();
      });
    }
  }

  void _onPressMin() {
    if(weight > 10){
      setState(() {
        weight = int.parse(weightController.text);
        weight = weight - 1;
        weightController.text  = weight.toString();
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
              Text(
                "กรอกข้อมูลน้ำหนัก",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                            "น้ำหนัก",
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
                                return "กรุณาป้อนน้ำหนัก";
                              }
                              if (int.parse(value) <= 0) {
                                return "กรุณาป้อนน้ำหนักมากกว่า 0";
                              }
                              if (int.parse(value) >= 151) {
                                return "กรุณาป้อนน้ำหนักต่ำกว่า 150";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              weightController.text = value!;
                            },
                            keyboardType: TextInputType.number,
                            controller: weightController,
                            textAlign: TextAlign.center,
                            //initialValue: weightController.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold
                            ),
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
