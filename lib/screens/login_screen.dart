import 'package:calories_counter_project/profiles/age.dart';
import 'package:calories_counter_project/profiles/gender.dart';
import 'package:calories_counter_project/screens/home_screen.dart';
import 'package:calories_counter_project/screens/register_screen.dart';
import 'package:calories_counter_project/widgets/bottombar.dart';
import 'package:calories_counter_project/widgets/multiPageProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Calories Calculator App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.green,
          ),
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
                      controller: emailController,
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
                        emailController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintText: "อีเมล",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: passwordController,
                      obscureText: true,
                      validator: (value){
                        RegExp regexp = new RegExp(r'^.{6,}$');
                        if(value!.isEmpty){
                          return ("กรุณากรอกรหัสผ่าน");
                        }
                        if(!regexp.hasMatch(value)){
                          return ("กรุณากรอกรหัสผ่านให้ถูกต้อง - ต่ำสุดได้ 6 ตัวอักษร");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        passwordController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        hintText: "รหัสผ่าน",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF5fb27c),
                      child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          signIn(emailController.text, passwordController.text);
                        },
                        child: Text(
                          "เข้าสู่ระบบ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("ถ้าหากยังไม่มีบัญชี  "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RegisterScreen();
                            }));
                          },
                          child: Text(
                            "สมัครสมาชิก",
                            style: TextStyle(
                                color: Color(0xFF5fb27c),
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        )
                      ],
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

  void signIn(String email, String password) async{
    if(formKey.currentState!.validate()){
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
            Fluttertoast.showToast(msg: "เข้าสู่ระบบสำเร็จ"),
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return BottomBar();
            }))
          }).catchError((e){
            Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
