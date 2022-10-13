import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/confirmProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class tdeeForm extends StatefulWidget {
  final Users user;
  const tdeeForm({Key? key, required this.user}) : super(key: key);

  @override
  State<tdeeForm> createState() => _tdeeFormState(user);
}

class _tdeeFormState extends State<tdeeForm> {
  final Users user;
  _tdeeFormState(this.user);

  late bool _isButtonDisabled;
  @override
  void initState() {
    _isButtonDisabled = true;
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  Users userData = Users(
    tdee: "",
  );

  dataNavigation(BuildContext context) {
    Users users = Users(
        gender: user.gender,
        name: user.name,
        age: user.age,
        weight: user.weight,
        height: user.height,
        tdee: userData.tdee
    );

    if (formKey.currentState != null && formKey.currentState!.validate() && selectorExercise != 0) {
      print(users.gender);
      print(users.name);
      print(users.age);
      print(users.height);
      print(users.weight);
      print(users.tdee);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => confirmProfileScreen(user: users),
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
                          userData = Users(
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
                                fontWeight: FontWeight.bold
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          userData = Users(
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
                                fontWeight: FontWeight.bold
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          userData = Users(
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
                                fontWeight: FontWeight.bold
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          userData = Users(
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
                                fontWeight: FontWeight.bold
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        setState(() {
                          userData = Users(
                            tdee: "1.9",
                          );
                          selectorExercise = 5;
                          _isButtonDisabled = false;
                        },),
                    child: Container(
                      height:50,
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
                                fontWeight: FontWeight.bold
                            ),
                            textScaleFactor: 1.0,
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
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF5fb27c),
                        child: _isButtonDisabled ?
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
                        :MaterialButton(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width - 30,
                          onPressed: () {
                            dataNavigation(context);
                          },
                          child: const Text(
                            "ยืนยัน",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

}
