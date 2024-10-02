import 'package:fitness/services/app_colors.dart';
import 'package:flutter/material.dart';

class TestimoniesScreen extends StatefulWidget {
  const TestimoniesScreen({super.key});

  @override
  State<TestimoniesScreen> createState() => _TestimoniesScreenState();
}

class _TestimoniesScreenState extends State<TestimoniesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testimonies"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(Icons.person,size: 50,),
                ),
                title: Text("fdfdfdfdfdf"),
                trailing: Checkbox(
                    value: false,
                    onChanged: (val){

                    }
                ),
              )
            );
          },
        ),
      ),
    );
  }
}
