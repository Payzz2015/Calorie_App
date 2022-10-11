import 'package:flutter/material.dart';

class DetailFood extends StatefulWidget {
  final String name;
  final String calories;
  final String fat;
  final String carbohydrate;
  final String protein;
  final String sugar;
  final String sodium;
  const DetailFood({Key? key,required this.name,required this.calories, required this.fat, required this.carbohydrate, required this.protein,required this.sugar, required this.sodium}) : super(key: key);

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Color(0xFF5fb27c),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.name.toString(),style: TextStyle(color: Colors.black),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
