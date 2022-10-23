import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/profiles/gender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formKey = GlobalKey<FormState>();

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  final firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    confirmPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text(
          "สมัครสมาชิก",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF5fb27c),
          ),
          textScaleFactor: 1.5,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      autofocus: false,
                      controller: emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(value!.isEmpty){
                          return ("กรุณากรอกอีเมล");
                        }
                        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)){
                          return ("กรุณากรอกอีเมลให้ถูกต้อง");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailEditingController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        prefixIcon: const Icon(Icons.mail),
                        hintText: "อีเมล",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: passwordEditingController,
                      obscureText: true,
                      validator: (value){
                        RegExp regexp = RegExp(r'^.{6,}$');
                        if(value!.isEmpty){
                          return ("กรุณากรอกรหัสผ่าน");
                        }
                        if(!regexp.hasMatch(value)){
                          return ("กรุณากรอกรหัสผ่านให้ถูกต้อง - ต่ำสุดได้ 6 ตัวอักษร");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordEditingController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        prefixIcon: const Icon(Icons.key),
                        hintText: "รหัสผ่าน",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: confirmPasswordEditingController,
                      obscureText: true,
                      validator: (value){
                        if(confirmPasswordEditingController.text.length > 6
                        && passwordEditingController.text != value){
                          return ("รหัสผ่านไม่ตรงกัน");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        confirmPasswordEditingController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        prefixIcon: const Icon(Icons.key),
                        hintText: "ยืนยันรหัสผ่านอีกครั้ง",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF5fb27c),
                      child: MaterialButton(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          signUp(
                              emailEditingController.text,
                              passwordEditingController.text
                          );
                        },
                        child: const Text(
                          "สมัครสมาชิก",
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async{
    String errorMessage;
    if(formKey.currentState!.validate()){
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            collectToFirestore()
      }).catchError((e){
        switch (e!.code) {
          case "invalid-email":
            errorMessage = "กรุณากรอกรูปแบบอีเมลให้ถูกต้อง";
            break;
          case "email-already-in-use":
            errorMessage = "อีเมลนี้มีผู้ใช้งานแล้ว";
            break;
          case "weak-password":
            errorMessage = "พาสเวิร์ดนี้อ่อนแอเกินไป";
            break;
          case "operation-not-allowed":
            errorMessage = "การสมัครด้วยอีเมลและพาสเวิร์ดไม่เปิดใช้งาน";
            break;
          default:
            errorMessage = "ไม่ทราบสาเหตุ";
        }
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 15,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent,
          gravity: ToastGravity.BOTTOM_LEFT,
        );
      });
    }
  }

  collectToFirestore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = firebaseAuth.currentUser;

    Users users = Users();

    users.email = user!.email;
    users.uid = user.uid;


    await firebaseFirestore.collection("users").doc(user.uid).set(users.toMap());
    Fluttertoast.showToast(
        msg: "สร้างบัญชีผู้ใช้สำเร็จ",
        toastLength: Toast.LENGTH_LONG,
        fontSize: 15,
        textColor: Colors.white,
        backgroundColor: Colors.indigoAccent,
        gravity: ToastGravity.BOTTOM_LEFT,
    );

    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context){
      return const genderSelector();
    }), (route) => false);

  }
}
