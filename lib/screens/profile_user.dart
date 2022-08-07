import 'package:calories_counter_project/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Profile")]
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                //Text(auth.currentUser.email,style: TextStyle(fontSize: 25),),
                ElevatedButton(onPressed: (){
                  auth.signOut().then((value){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context){
                          return Home();
                        }));
                  });
                }, child: Text("แก้ไขข้อมูลส่วนตัว")
                ),
                ElevatedButton(onPressed: (){
                  auth.signOut().then((value){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context){
                          return Home();
                        }));
                  });
                }, child: Text("ออกจากระบบ")
                ),
              ],
            ),
          ),
        ),
    );
  }
}
