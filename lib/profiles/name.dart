import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/age.dart';
import 'package:flutter/material.dart';

class nameForm extends StatefulWidget {
  final Users user;
  const nameForm({Key? key, required this.user}) : super(key: key);

  @override
  State<nameForm> createState() => _nameFormState(user);
}

class _nameFormState extends State<nameForm> {

  final Users user;
  _nameFormState(this.user);

  late bool _isButtonDisabled;
  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  dataNavigation(BuildContext context) {
    Users users = Users(
      gender: user.gender,
      name: nameController.text,
    );
    if (formKey.currentState != null && formKey.currentState!.validate()) {
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
      body:
      Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "ชื่อผู้ใช้งาน",
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
                    cursorColor: Colors.green,
                    onChanged: (value){
                      setState(() {
                        if(nameController.text.isNotEmpty){
                          _isButtonDisabled = false;
                        }
                        if(nameController.text.isEmpty){
                          _isButtonDisabled = true;
                        }
                      });
                    },
                    onSaved: (value) {
                      nameController.text = value!;
                    },
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
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
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
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
            )
          ],
        ),
      ),
    );
  }
}
