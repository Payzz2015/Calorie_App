import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  User? user = FirebaseAuth.instance.currentUser;
  Users users = Users();

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .get()
      .then((value){
        this.users = Users.fromMap(value.data());
        setState(() {

        });
    });
  }

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
                Text("อีเมล: ${users.email}",style: TextStyle(fontSize: 25),),
                Text("ชื่อ: ${users.name}",style: TextStyle(fontSize: 25),),
                Text("เพศ: ${users.gender}",style: TextStyle(fontSize: 25),),
                Text("อายุ: ${users.age}",style: TextStyle(fontSize: 25),),
                Text("น้ำหนัก: ${users.weight}",style: TextStyle(fontSize: 25),),
                Text("ส่วนสูง: ${users.height}",style: TextStyle(fontSize: 25),),
               ElevatedButton(
                  onPressed: (){

                  },
                  child: Text("แก้ไขข้อมูลส่วนตัว"),
                ),
                ElevatedButton(
                  onPressed: (){
                    signOut(context);
                  },
                  child: Text("ออกจากระบบ")
                ),
              ],
            ),
          ),
        ),
    );
  }

  Future<void> signOut(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return LoginScreen();
    }));
  }
}
