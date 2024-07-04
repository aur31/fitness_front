import 'package:flutter/material.dart';

class SportScreen extends StatefulWidget {
  const SportScreen({super.key});

  @override
  State<SportScreen> createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            
          },
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          
        ],
      ),
    );
  }
}
