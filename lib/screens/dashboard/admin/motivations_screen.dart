import 'package:flutter/material.dart';

class MotivationScreen extends StatefulWidget {
  const MotivationScreen({super.key});

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Motivations"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("/add_motivation");
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: Container(
                  width: 20,
                  height: 70,
                  color: Colors.primaries[index % Colors.primaries.length],
                  child: Center(child: Text("$index")),
                ),
                title: Container(
                  margin: EdgeInsets.only(left: 10),
                  //color: Colors.primaries[index % Colors.primaries.length],
                  child: Text("datadgdfgdfgdfgdfgg"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
