import 'package:calories_counter_project/screens/register_screen.dart';
import 'package:calories_counter_project/widgets/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "เข้าสู่ระบบ",
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
                      controller: passwordController,
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
                        passwordController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key),
                        hintText: "รหัสผ่าน",
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
                          signIn(emailController.text, passwordController.text);
                        },
                        child: const Text(
                          "เข้าสู่ระบบ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("ถ้าหากยังไม่มีบัญชี  "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const RegisterScreen();
                                }));
                          },
                          child: const Text(
                            "สมัครสมาชิก",
                            style: TextStyle(
                                color: Color(0xFF5fb27c),
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
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
    String errorMessage;
    if(formKey.currentState!.validate()){
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        Fluttertoast.showToast(
          msg: "เข้าสู่ระบบสำเร็จ",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 15,
          textColor: Colors.white,
          backgroundColor: Colors.indigoAccent,
          gravity: ToastGravity.BOTTOM_LEFT,
        ),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return const BottomBar();
        }))
      }).catchError((e){
        switch (e!.code) {
          case "invalid-email":
            errorMessage = "กรุณากรอกรูปแบบอีเมลให้ถูกต้อง";
            break;
          case "wrong-password":
            errorMessage = "รหัสผ่านของคุณผิด";
            break;
          case "user-not-found":
            errorMessage = "ไม่พบอีเมลของผู้ใช้งาน";
            break;
          case "user-disabled":
            errorMessage = "อีเมลของคุณถูกปิดการใช้งาน";
            break;
          case "too-many-requests":
            errorMessage = "คำขอมากเกินไป ลองใหม่อีกครั้งในภายหลัง";
            break;
          case "operation-not-allowed":
            errorMessage = "การล็อคอินด้วยอีเมลและพาสเวิร์ดไม่เปิดใช้งาน";
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

}