import 'package:fitness/services/sharedPreferences.dart';
import 'package:fitness/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  late FocusNode _emailFocusNode,_pwdFocusNode;
  late TextEditingController _emailController,_pwdController;

  @override
  void initState() {
    // TODO: implement initState
    _emailFocusNode = new FocusNode();
    _pwdFocusNode = new FocusNode();
    _emailController = new TextEditingController();
    _pwdController = new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            SizedBox(height: 20,),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      autofocus: false,
                      decoration: new InputDecoration(
                        hintText: "Email",
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
                      //keyboardType: const TextInputType.numberWithOptions(),
                      inputFormatters: [
                        //FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (val){

                      },
                      maxLines: 1,
                      validator: (value){

                      },
                      onTapOutside: (dd){
                        _emailFocusNode.unfocus();
                      },
                      autocorrect: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // Only numbers can be entered
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: _pwdController,
                      focusNode: _pwdFocusNode,
                      autofocus: false,
                      decoration: new InputDecoration(
                        hintText: "Password",
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
                      //keyboardType: const TextInputType.numberWithOptions(),
                      inputFormatters: [
                        //FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (val){

                      },
                      maxLines: 1,
                      validator: (value){

                      },
                      onTapOutside: (dd){
                        _pwdFocusNode.unfocus();
                      },
                      autocorrect: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // Only numbers can be entered
                    ),

                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                              var data = {
                                "email": _emailController.text,
                                "password": _pwdController.text,
                              };
                              await context.read<UserViewModel>().login(context, data).then((val){
                                if(val){
                                  if(context.read<AppSharedPreferences>().user!.role == 0){
                                    Navigator.of(context).pushNamed("/admin_dash");
                                  }else{
                                    Navigator.of(context).pushNamed("/user_dash");
                                  }
                                }
                              });

                            },
                            child: Text("Login")
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
