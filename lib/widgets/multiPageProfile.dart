// /*
// import 'package:calories_counter_project/models/User.dart';
// import 'package:calories_counter_project/profiles/age.dart';
// import 'package:calories_counter_project/profiles/gender.dart';
// import 'package:calories_counter_project/profiles/height.dart';
// import 'package:calories_counter_project/profiles/weight.dart';
// import 'package:calories_counter_project/screens/home_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class multiPage extends StatefulWidget {
//   const multiPage({Key? key}) : super(key: key);
//
//   @override
//   State<multiPage> createState() => _multiPageState();
// }
//
// class _multiPageState extends State<multiPage> {
//   int currentPage = 0;
//   final List<Widget> pages = [
//     genderSelector(),
//     ageForm(),
//     weightForm(),
//     heightForm(),
//   ];
//
//   final PageStorageBucket bucket = PageStorageBucket();
//   Widget currentScreen = genderSelector();
//
//   final firebaseAuth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     bool useKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
//     return Scaffold(
//         body: PageStorage(
//           child: currentScreen,
//           bucket: bucket,
//         ),
//         floatingActionButton: Visibility(
//           visible: !useKeyboard,
//           child: _getFloatingButton(),
//         ),
//     );
//   }
//
//   Widget _getFloatingButton() {
//     if (currentPage == 0) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//               backgroundColor: Color(0xFF03AC13),
//               child: Icon(Icons.arrow_forward_ios_outlined,size: 35,),
//               onPressed: (){
//                 setState(() {
//                   currentScreen = ageForm();
//                   currentPage = 1;
//                 });
//               }),
//         ],
//       );
//     } else if (currentPage == 1) {
//       return Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//                 FloatingActionButton(
//                   backgroundColor: Color(0xFF03AC13),
//                   child: Icon(Icons.arrow_back_ios_new_rounded,size: 35,),
//                   onPressed: (){
//                     setState(() {
//                       currentScreen = genderSelector();
//                       currentPage = 0;
//                     });
//                   },
//                 ),
//                 SizedBox(width: 20,),
//                 FloatingActionButton(
//                   backgroundColor: Color(0xFF03AC13),
//                   child: Icon(Icons.arrow_forward_ios_rounded,size: 35,),
//                   onPressed: (){
//                     setState(() {
//                       currentScreen = weightForm();
//                       currentPage = 2;
//                     });
//                   },
//                 )
//             ]
//       );
//     }
//     else if (currentPage == 2) {
//       return Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             FloatingActionButton(
//               backgroundColor: Color(0xFF03AC13),
//               child: Icon(Icons.arrow_back_ios_new_rounded,size: 35,),
//               onPressed: () {
//                 dataNavigation(context);
//                   setState(() {
//                     currentScreen = ageForm();
//                     currentPage = 1;
//                   });
//               },
//             ),
//             SizedBox(width: 20,),
//             FloatingActionButton(
//               backgroundColor: Color(0xFF03AC13),
//               child: Icon(Icons.arrow_forward_ios_rounded,size: 35,),
//               onPressed: () {
//                 setState(() {
//                   currentScreen = heightForm();
//                   currentPage = 3;
//                 });
//               },
//             )
//           ]
//       );
//     }else if (currentPage == 3) {
//       return Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             FloatingActionButton(
//               backgroundColor: Color(0xFF03AC13),
//               child: Icon(Icons.arrow_back_ios_new_rounded,size: 35,),
//               onPressed: () {
//                 setState(() {
//                   currentScreen = weightForm();
//                   currentPage = 2;
//                 });
//               },
//             ),
//             SizedBox(width: 20,),
//             FloatingActionButton(
//               backgroundColor: Colors.green.shade700,
//               child: Icon(
//                 Icons.check,
//                 size: 35,
//               ),
//               onPressed: () async{
//
//               },
//             )
//           ]
//       );
//     } else {
//       return Container();
//     }
//   }
//
//   collectToFirestore() async{
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     User? user = firebaseAuth.currentUser;
//
//     Users users = Users();
//
//     users.uid = user!.uid;
//
//     await firebaseFirestore.collection("users").doc(user.uid).set(users.toMap());
//     Fluttertoast.showToast(msg: "สร้างบัญชีผู้ใช้สำเร็จ");
//
//     Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context){
//       return HomeScreen();
//     }), (route) => false);
//
//   }
//
//   void dataNavigation(BuildContext context) {
//
//   }
// }
// */
