import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:flutter/material.dart';

class ManageMeal extends StatefulWidget {
  final DateTime date;
  const ManageMeal({Key? key, required this.date}) : super(key: key);

  @override
  State<ManageMeal> createState() => _ManageMealState(date);
}

class _ManageMealState extends State<ManageMeal> {

  final DateTime date;
  _ManageMealState(this.date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5fb27c),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "จัดการมื้ออาหาร",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
                "วันที่ ${date.day}-${date.month}-${date.yearInBuddhistCalendar}"
            ),
            Text("มื่อเช้า"),
            Text("มื่อเช้า"),
            Text("มื่อเช้า"),
            Text("มื่อเช้า"),
          ],
        ),
      ),
    );
  }
}
