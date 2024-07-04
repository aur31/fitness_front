import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Text("menu 1"),
      ),
    );
  }
}
