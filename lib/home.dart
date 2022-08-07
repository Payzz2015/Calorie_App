import 'package:calories_counter_project/screens/login_screen.dart';
import 'package:calories_counter_project/screens/register_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register/Login",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                Image.asset(
                  "assets/logos/example2.png",
                  height: 200,
                  width: 200,
                ),
                Text(
                  "Calories",
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.login),
                      label: Text(
                        "เข้าสู่ระบบ",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      }),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      label: Text(
                        "สร้างบัญชี",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }));
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
