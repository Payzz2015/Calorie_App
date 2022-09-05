import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calories_counter_project/profiles/resetData/newGender.dart';

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
  Widget build(BuildContext context) {
    // Stream documentStream = FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots();
    //final Stream<QuerySnapshot> _usersStream = firebaseFirestore.collection('users').snapshots(includeMetadataChanges: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5fb27c),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "โปรไฟล์ของคุณ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              signOut(context);
            },
            icon: const Icon(
              Icons.exit_to_app,
              size: 28,
            ),
          )
        ],
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
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                "${snapshot.data['weight']} kg",
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
                                "${snapshot.data['height']} cm",
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
                        color: const Color(0xFF00aca0),
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
                        height: 20,
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
          title: const Text("ต้องการตั้งข้อมูลใหม่ใช่หรือไม่"),
          actions: [
            MaterialButton(
              child: const Text("ตกลง"),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return const newDataGender();
                }));
              }
            ),
            MaterialButton(
                child: const Text("ยกเลิก"),
                onPressed: (){
                  Navigator.of(context).pop();
                }
            ),
          ],
        );
      }
    );
  }

  Future<String?> openEditName() => showDialog<String>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text("เปลี่ยนชื่อโปรไฟล์ของคุณ"),
          content: TextField(
            controller: nameController,
            keyboardType: TextInputType.name,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "ใส่ชื่อของคุณ",
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: (){
                Navigator.of(context).pop(nameController.text);

                nameController.clear();
              },
              child: const Text("ยืนยัน"),
            ),
            MaterialButton(
              onPressed: (){
                Navigator.of(context).pop();

                nameController.clear();
              },
              child: const Text("ยกเลิก"),
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
