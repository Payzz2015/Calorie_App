import 'package:flutter/material.dart';

class FormPhoto extends StatefulWidget {
  const FormPhoto({Key? key}) : super(key: key);

  @override
  State<FormPhoto> createState() => _FormPhotoState();
}

class _FormPhotoState extends State<FormPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5fb27c),
        foregroundColor: Colors.white,
        title: Text("เพิ่มรูปภาพ"),
      ),
      body: Center(child: Text("Form Photo"),),
    );
  }
}
