import 'package:fitness/main.dart';
import 'package:fitness/services/app_colors.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:fitness/viewmodel/encouragement_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMotivation extends StatefulWidget {
  const AddMotivation({super.key});

  @override
  State<AddMotivation> createState() => _AddMotivationState();
}

class _AddMotivationState extends State<AddMotivation> {
  late TextEditingController _otivationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _otivationController = new TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _otivationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Motivation"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset("assets/images/logo.png",),
                SizedBox(height: 40,),
                TextFormField(
                  controller: _otivationController,
                  decoration: InputDecoration(
                    hintText: "motivation",
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
                  maxLines: 10,
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        //shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        //minimumSize: Size(100, 40), //////// HERE
                      ),
                      onPressed: ()async{
                        var data = {
                          "encouragement" : _otivationController.text,
                          "user_id": context.read<AppSharedPreferences>().user!.user_id,
                        };

                        await context.read<EncouragementViewModel>().register(context, data).then((val){
                          if(val){
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Text("Save")
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
