import 'package:flutter/material.dart';

class FoodPhoto extends StatelessWidget {
  const FoodPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Food Photo"),
          ],
        ),
      ),
    );
  }
}
