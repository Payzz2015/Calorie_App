import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calories_counter_project/profiles/resetData/newGender.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  TextEditingController nameController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Users users = Users();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      users = Users.fromMap(value.data());
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Stream documentStream = FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots();
    //final Stream<QuerySnapshot> _usersStream = firebaseFirestore.collection('users').snapshots(includeMetadataChanges: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF5fb27c),
        centerTitle: true,
        title: const Text(
          "ข้อมูลส่วนตัว",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(users.uid).snapshots(),
        builder: (context,AsyncSnapshot snapshot) {
          if (!snapshot.hasData || !snapshot.data.exists) {
            return const Center(
              // child: CircularProgressIndicator(),
            );
          }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            "ชื่อผู้ใช้งาน",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.grey[700],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 30,),
                              Text(
                                snapshot.data['name'],
                                //users.name?.toString() ?? "",
                                style: const TextStyle(
                                    color: Color(0xff02b194),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final name = await openEditName();
                                  if (name == null || name.isEmpty) return;

                                  setState(() {
                                    editName(nameUser: name);
                                  });
                                },
                                icon: const Icon(Icons.edit),
                                color: const Color(0xff000000),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "อีเมล",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            snapshot.data['email'],
                            style: const TextStyle(
                              fontSize: 25,
                              color: Color(0xff43ccba),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "เพศ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            snapshot.data['gender'],
                            style: const TextStyle(
                              fontSize: 25,
                              color: Color(0xff43ccba),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "อายุ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${snapshot.data['age']} ปี",
                            style: const TextStyle(
                              fontSize: 25,
                              color: Color(0xff43ccba),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ส่วนสูง",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${snapshot.data['height']} ซม.",
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff43ccba),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "น้ำหนัก",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${snapshot.data['weight']} กก.",
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff43ccba),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "BMI",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${snapshot.data['bmi']}",
                                // bmi.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff43ccba),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "BMR",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${snapshot.data['bmr']}",
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff43ccba),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF5fb27c),
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          minWidth: MediaQuery
                              .of(context)
                              .size
                              .width,
                          onPressed: () {
                            showAlertDialog();
                          },
                          child: const Text(
                            "ต้องการตั้งข้อมูลผู้ใช้ใหม่",
                            overflow: TextOverflow.ellipsis,
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
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffd7163d),
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          minWidth: MediaQuery
                              .of(context)
                              .size
                              .width,
                          onPressed: () {
                            signOut(context);
                            Fluttertoast.showToast(
                              msg: "ออกจากระบบเรียบร้อย",
                              toastLength: Toast.LENGTH_LONG,
                              fontSize: 15,
                              textColor: Colors.white,
                              backgroundColor: Colors.deepOrange,
                              gravity: ToastGravity.BOTTOM_LEFT,
                            );
                          },
                          child: const Text(
                            "ออกจากระบบ",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            );
        },
      ),
    );
  }

  void showAlertDialog(){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text(
            "ต้องการตั้งข้อมูลใหม่ใช่หรือไม่",
            style: TextStyle(
              fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.greenAccent,
                    child: const Text("ตกลง",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return const newDataGender();
                      }));
                    }
                ),
                SizedBox(width: 20,),
                MaterialButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.redAccent,
                    child: const Text("ยกเลิก",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                ),
              ],
            )
          ],
        );
      }
    );
  }

  Future<String?> openEditName() => showDialog<String>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text(
            "เปลี่ยนชื่อโปรไฟล์ของคุณ",
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "ชื่อ",
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.greenAccent,
                  onPressed: (){
                    Navigator.of(context).pop(nameController.text);

                    nameController.clear();
                  },
                  child: const Text("ยืนยัน",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                SizedBox(width: 20,),
                MaterialButton(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.redAccent,
                  onPressed: (){
                    Navigator.of(context).pop();

                    nameController.clear();
                  },
                  child: const Text("ยกเลิก",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                )
              ],
            )
          ],
        );
      }
  );

  Future editName({required String nameUser}) async{
    DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc(user!.uid);
    await documentReference.update({'name': nameUser});
  }


  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }
}
