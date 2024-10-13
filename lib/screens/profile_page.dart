import 'package:fitness/models/User.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:fitness/viewmodel/user_view_model.dart';
import 'package:fitness/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final client = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
        body: SafeArea(
          child: Stack(
              children: [
                // Background gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF4CAF50), // Green
                        Color(0xFF2196F3), // Blue
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      BackButton(color: Colors.white,style: ButtonStyle(foregroundColor: WidgetStateProperty.all<Color>(Colors.white)),),
                      Text("Details Client",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),

                // User profile content
                Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 80.0),
                          Center(
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: NetworkImage(
                                'https://via.placeholder.com/150',
                              ),
                              child: Text(
                                '${client.name![0]}',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Center(
                            child: Text(
                              '${client.name}',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          SizedBox(height: 24.0),
                          Expanded(
                              child: Container(
                                width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.all(24.0),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'About',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text(
                                              '${client.email}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black
                                              ),
                                            ),
                                            Text(
                                              '${client.sex}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ]
                                      )
                                  )
                              )
                          ),
                          TextButton(
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: BorderSide(color: Colors.lightGreen)
                                      )
                                  ),
                                  elevation: WidgetStateProperty.all<double>(10),
                                  backgroundColor: WidgetStateProperty.all<Color>(Colors.lightGreen),
                                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white)
                              ),
                              onPressed: ()async {
                                var data = {
                                  "email": context.read<AppSharedPreferences>().user!.email,
                                  "token": context.read<AppSharedPreferences>().token,
                                };
                                //print(context.read<AppSharedPreferences>().user!.height);
                                await context.read<UserViewModel>().logout(context, data).then((val){
                                  if(val){
                                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                                    Navigator.of(context).pushNamed("/");
                                  }
                                });
                              },
                              child: Text("Deconnexion")
                          ),
                        ]
                    )
                )
              ]
          ),
        )
    );
  }
}






