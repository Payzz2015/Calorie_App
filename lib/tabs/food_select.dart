import 'package:flutter/material.dart';

class FoodSelect extends StatelessWidget {
  const FoodSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Add"),
          ],
        ),
      ),
    );
  }
}
