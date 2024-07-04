import 'package:flutter/material.dart';

class Sport extends StatefulWidget {
  const Sport({super.key});

  @override
  State<Sport> createState() => _SportState();
}

class _SportState extends State<Sport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 150,
            child: ListView(
              children: [

              ],
            ),
          ),
          Center(
            child: Image.asset(
              "dsdsd",
              height: 200,
              width: 200,
            ),
          )
        ],
      ),
    );
  }
}
