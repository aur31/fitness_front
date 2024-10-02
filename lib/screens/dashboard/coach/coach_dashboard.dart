import 'package:fitness/services/app_colors.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoachDashboard extends StatefulWidget {
  const CoachDashboard({super.key});

  @override
  State<CoachDashboard> createState() => _CoachDashboardState();
}

class _CoachDashboardState extends State<CoachDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coach DashBoard"),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).pushNamed("/profile",arguments: context.read<AppSharedPreferences>().user);
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.person,size: 50,),
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              builder: (context){
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text("Category"),
                        trailing: TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: "new category",
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                              ),
                                            ),
                                            maxLines: 1,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors.primaryColor,
                                                  foregroundColor: Colors.white,
                                                  //shadowColor: Colors.greenAccent,
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15.0)
                                                  ),
                                                  //minimumSize: Size(100, 40), //////// HERE
                                                ),
                                                onPressed: (){

                                                },
                                                child: Text("Save")
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                              );
                            },
                            child: Text("add")
                        ),
                      ),
                      ListTile(
                        title: Text("Exercise"),
                        trailing: TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 200,
                                            color: Colors.black,
                                            child: Center(
                                              child: Icon(Icons.photo_library,color: Colors.white,),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: "name exercise",
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                              ),
                                            ),
                                            maxLines: 1,
                                          ),
                                          SizedBox(height: 10,),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: "Duration",
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                              ),
                                            ),
                                            maxLines: 1,
                                          ),
                                          ListTile(
                                            leading: Text("Category"),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors.primaryColor,
                                                  foregroundColor: Colors.white,
                                                  //shadowColor: Colors.greenAccent,
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15.0)
                                                  ),
                                                  //minimumSize: Size(100, 40), //////// HERE
                                                ),
                                                onPressed: (){

                                                },
                                                child: Text("Save")
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                              );
                            },
                            child: Text("add")
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("categories"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context,index){
                return ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    color: Colors.black,
                  ),
                  title: Text("name"),
                  subtitle: Text("Duration"),
                  trailing: TextButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 200,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 10,),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "name exercise",
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                                        ),
                                      ),
                                      maxLines: 1,
                                    ),
                                    SizedBox(height: 10,),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Duration",
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                                        ),
                                      ),
                                      maxLines: 1,
                                    ),
                                    ListTile(
                                      leading: Text("Category"),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              //shadowColor: Colors.greenAccent,
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0)
                                              ),
                                              //minimumSize: Size(100, 40), //////// HERE
                                            ),
                                            onPressed: (){

                                            },
                                            child: Text("delete")
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.primaryColor,
                                              foregroundColor: Colors.white,
                                              //shadowColor: Colors.greenAccent,
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0)
                                              ),
                                              //minimumSize: Size(100, 40), //////// HERE
                                            ),
                                            onPressed: (){

                                            },
                                            child: Text("Save")
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
                        );
                      },
                      child: Text("Update")
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
