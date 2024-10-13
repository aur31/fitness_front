import 'package:fitness/models/User.dart';
import 'package:fitness/services/app_colors.dart';
import 'package:fitness/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewUsersScreen extends StatefulWidget {
  const ViewUsersScreen({super.key});

  @override
  State<ViewUsersScreen> createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {

  final _searchController = TextEditingController();
  List<User> suggestions = [];
  int? _role;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((val)async{
      await context.read<UserViewModel>().getUsers().then((val){
        if(val){
          suggestions.addAll(context.read<UserViewModel>().users);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Displayer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<UserViewModel>(
          builder: (context,userViewModel,child){
            if(userViewModel.users.length - suggestions.length == 1){
              suggestions.clear();
              suggestions.addAll(context.read<UserViewModel>().users);
            }

            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _role,
                        decoration: InputDecoration(labelText: 'Role'),
                        items: [
                          DropdownMenuItem(child: Text('Admin'), value: 0),
                          DropdownMenuItem(child: Text('Diet'), value: 1),
                          DropdownMenuItem(child: Text('Coache'), value: 2),
                          DropdownMenuItem(child: Text('Employee'), value: 3),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _role = value;
                            suggestions.clear();
                            suggestions.addAll(context.read<UserViewModel>().users.where((element)=>element.role == _role));
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: _role != null,
                      child: IconButton(
                          onPressed: (){
                            setState(() {
                              _role = null;
                              suggestions.clear();
                              suggestions.addAll(context.read<UserViewModel>().users);
                            });
                          },
                          icon: Icon(Icons.clear,color: Colors.red,)
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15,),
                /*Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(Icons.person,size: 50,),
                      ),
                      title: Text("fdfdfdfdfdf"),
                    )
                ),*/
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Rechercher...',
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          prefixIcon: Icon(Icons.search),
                          //border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          suggestions.clear();
                          suggestions.addAll(userViewModel.users.where((element)=>element.name!.toLowerCase().contains(value.toLowerCase())));

                          if(value.isEmpty){
                            suggestions.clear();
                            suggestions.addAll(userViewModel.users);
                          }
                          setState(() {

                          });
                        },
                      ),
                    ),
                    SizedBox(width: 20,),
                    IconButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed("/add_user");
                        },
                        icon: Icon(Icons.add)
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestions.length,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.primaries[index % Colors.primaries.length]
                                    ),
                                    child: Text("${suggestions[index].name![0]}".toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 10),)
                                ),
                                SizedBox(width: 10,),
                                Text("${suggestions[index].name}".toUpperCase(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 10),),
                              ],
                            ),
                            //SizedBox(height: 10,),
                            Text("${suggestions[index].email}",style: TextStyle(),),

                          ],
                        ),
                      );
                    },
                  ),
                ),

              ],
            );
          },
        ),
      )
    );
  }
}
