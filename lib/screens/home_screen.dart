import 'package:calories_counter_project/models/User.dart';
import 'package:calories_counter_project/screens/statsOfday_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser!;
  Users users = Users();

  @override
  Widget build(BuildContext context) {
    return const StatsOfDayScreen();
  }
}
