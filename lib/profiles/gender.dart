import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/age.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class genderSelector extends StatefulWidget {
  const genderSelector({Key? key}) : super(key: key);

  @override
  State<genderSelector> createState() => _genderSelectorState();
}

class _genderSelectorState extends State<genderSelector> {

  final formKey = GlobalKey<FormState>();

  Users userData = Users(
    gender: "",
  );

  dataNavigation(BuildContext context) {
    Users users = new Users(
        gender: userData.gender
    );
    if (formKey.currentState != null && formKey.currentState!.validate() && selectorGender != 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ageForm(user: users),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "เลือกเพศของคุณ",
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
          padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
          child: Container(
            child:
            Column(
              children: [
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
                        alignment: Alignment.center,
                        color: selectorGender == 1 ? Color(0xFF5fb27c) : Color(0xFFE4E6EA),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                    SizedBox(height: 190),
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
      ),
    );
  }

}

