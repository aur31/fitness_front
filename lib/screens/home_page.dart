import 'package:fitness/screens/dashboard/admin/admin_dashboard.dart';
import 'package:fitness/screens/dashboard/coach/coach_dashboard.dart';
import 'package:fitness/screens/dashboard/user/user_dashboard.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dashboard/diet/diet_dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formkey = GlobalKey<FormState>();
  late FocusNode _bmiFocusNode,_weiFocusNode,_heiFocusNode;
  late TextEditingController _bmiController,_weiController,_heiController;
  double bmi = 0.0;



  @override
  void initState() {
    // TODO: implement initState
    context.read<AppSharedPreferences>().checkIfLogIn();
    _weiFocusNode = new FocusNode();
    _heiFocusNode = new FocusNode();
    _weiController = new TextEditingController();
    _heiController = new TextEditingController();
    super.initState();
  }

  Widget nonLogin()=>Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Your Fitness",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
          SizedBox(height: 20,),
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _weiController,
                    focusNode: _weiFocusNode,
                    autofocus: false,
                    decoration: new InputDecoration(
                      hintText: "Enter your Weight (kg)",
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 5,left: 10),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [
                      //FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val){

                    },
                    maxLines: 1,
                    validator: (value){

                    },
                    onTapOutside: (dd){
                      _weiFocusNode.unfocus();
                    },
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // Only numbers can be entered
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: _heiController,
                    focusNode: _heiFocusNode,
                    autofocus: false,
                    decoration: new InputDecoration(
                      hintText: "Enter your Height (cm)",
                      filled: true,
                      contentPadding: EdgeInsets.only(top: 5,left: 10),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 1.0),
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [
                      //FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val){

                    },
                    maxLines: 1,
                    validator: (value){

                    },
                    onTapOutside: (dd){
                      _heiFocusNode.unfocus();
                    },
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // Only numbers can be entered
                  ),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: bmi != 0,
                        child: Row(
                          children: [
                            Text("BMI : ${bmi == 0 ? "" : bmi.toString().substring(0,7)}"),
                            IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.info,color: Colors.blueAccent,)
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
                            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  //side: BorderSide(color: Colors.black)
                                )
                            ),
                          ),
                          onPressed: ()async{
                            //Navigator.popUntil(context,ModalRoute.withName("/"));
                            setState(() {
                              bmi = double.parse(_weiController.text) / (double.parse(_heiController.text) * double.parse(_heiController.text));
                            });
                          },
                          child: Text("Calculate BMI")
                      ),
                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed("/register");
                          },
                          child: Text("Create Account?",style: TextStyle(color: Colors.blueAccent),)
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed("/login");
                          },
                          child: Text("Connect",style: TextStyle(color: Colors.blueAccent),)
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {

    return Consumer<AppSharedPreferences>(
      builder: (context,appSharedPreferences,child){
        if(!appSharedPreferences.getLoginStatus) return nonLogin();
        if(appSharedPreferences.user!.role == 0) return AdminDashboard();
        if(appSharedPreferences.user!.role == 1) return DietDashboard();
        if(appSharedPreferences.user!.role == 2) return CoachDashboard();
        if(appSharedPreferences.user!.role == 3) return UserDashboard();
        return nonLogin();
      },
    );

    return
      context.read<AppSharedPreferences>().getLoginStatus != true ? nonLogin() :
      context.read<AppSharedPreferences>().user!.role == 0 ? AdminDashboard() : UserDashboard();

      /*context.read<AppSharedPreferences>().getLoginStatus == true ?
      context.read<AppSharedPreferences>().user!.role == 0 ? AdminDashboard() :
      context.read<AppSharedPreferences>().user!.role == 1 ? UserDashboard() :
      nonLogin() : Container(child: Text("dddddd"),);*/
  }
}
