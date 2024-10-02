import 'package:fitness/services/app_colors.dart';
import 'package:flutter/material.dart';

class ViewUsersScreen extends StatefulWidget {
  const ViewUsersScreen({super.key});

  @override
  State<ViewUsersScreen> createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Displayer"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("choose role"),
          ),
          Divider(),
          Expanded(
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
                    )
                );
              },
            ),
          )
        ],
      )
    );
  }
}
