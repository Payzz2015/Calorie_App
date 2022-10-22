import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/resetData/newAge.dart';
import 'package:flutter/material.dart';

class newDataGender extends StatefulWidget {
  const newDataGender({Key? key}) : super(key: key);

  @override
  State<newDataGender> createState() => _newDataGenderState();
}

class _newDataGenderState extends State<newDataGender> {

  late bool _isButtonDisabled;
  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;
  }

  final formKey = GlobalKey<FormState>();
  Users userData = Users(
    gender: "",
  );

  dataNavigation(BuildContext context) {
    Users users = Users(
        gender: userData.gender,
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
    return Scaffold(
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
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
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
                          _isButtonDisabled = false;
                        },),
                    child: Container(
                      height: 150,
                      width: 150,
                      color: selectorGender == 1 ? const Color(0xFF5fb27c) : const Color(0xFFE4E6EA),
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
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          userData = Users(
                            gender: "หญิง",
                          );
                          selectorGender = 2;
                          _isButtonDisabled = false;
                        },),
                    child: Container(
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                      color: selectorGender == 2 ? const Color(0xFF5fb27c) : const Color(0xFFE4E6EA),
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
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF5fb27c),
                    child: _isButtonDisabled
                        ?MaterialButton(
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
                    :MaterialButton(
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
              )
            ],
          ),
        ),
      ),
    );
  }

}

