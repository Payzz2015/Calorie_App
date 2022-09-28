import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/resetData/newHeight.dart';
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

  late bool _isButtonDisabled;
  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController ageController = TextEditingController();

  dataNavigation(BuildContext context) {
    Users users = Users(
      gender: user.gender,
      age: ageController.text,
    );
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      print(user.gender);
      print(user.name);
      print(users.age);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => newDataHeight(user: users),
        ),
      );
    } else {
      return;
    }
  }

  String errorText = "";

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
                    height: 190,
                    width: 200,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value){
                        setState(() {
                          if(value.isNotEmpty){
                            _isButtonDisabled = false;
                          }
                          if(value.isEmpty){
                            _isButtonDisabled = true;
                          }
                          if(int.parse(value) <= 13){
                            errorText = "กรุณาป้อนอายุมากกว่า 13";
                            _isButtonDisabled = true;
                          }
                        });
                      },
                      onSaved: (value) {
                        ageController.text = value!;
                      },
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      textAlign: TextAlign.center,
                      //initialValue: weightController.text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixText: "ปี",
                        suffixStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Colors.grey
                            )
                        ),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Colors.grey
                            )
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Colors.green
                            )
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Colors.grey
                            )
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Colors.red
                            )
                        ),
                        errorText: _isButtonDisabled == false ? null : errorText,
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
