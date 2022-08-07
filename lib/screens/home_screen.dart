import 'package:flutter/material.dart';

import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Center(
              child:
              Text("Home")
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (conetext) {
                  return HistoryScreen();
                }));
              },
              icon: Icon(
                Icons.calendar_month_rounded,
                size: 28,
              ),
            )
          ],
        ),
        body: Center(
          child: Text("Home"),
        ));
  }
}
