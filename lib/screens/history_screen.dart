import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5fb27c),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("ประวัติย้อนหลัง",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25
          ),
        ),
      ),
      body: SfCalendar(
        todayHighlightColor: const Color(0xFF5fb27c),
        todayTextStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        view: CalendarView.month,
        monthViewSettings: const MonthViewSettings(
            showAgenda: true
        ),
      )
    );
  }
}
