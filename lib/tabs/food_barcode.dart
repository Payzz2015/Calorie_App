import 'package:flutter/material.dart';

class FoodBarcode extends StatelessWidget {
  const FoodBarcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              Text("Food Barcode"),
            ],
          ),
      ),
    );
  }
}
