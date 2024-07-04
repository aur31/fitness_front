import 'package:fitness/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late FocusNode _heightFocusNode,_nomFocusNode,_emailFocusNode,_pwdFocusNode,_weightFocusNode;
  late TextEditingController _heightController,_weightController,_pwdController,_nomController,_emailController;

  int opeartor = 0;
  late String _name;
  late String _email;
  late String _phone;
  late DateTime _lastVisit;

  void operatorCheck(String number){
    if(number.toString().substring(0,1).compareTo("6") == 0){
      if(number.toString().substring(1,2).compareTo("7") == 0){
        opeartor = 1;
        return;
      }

      if(number.toString().substring(1,2).compareTo("9") == 0){
        opeartor = 2;
        return;
      }

      if(number.toString().substring(1,2).compareTo("5") == 0){
        if(int.parse(number.toString().substring(2,3)) < 5){
          opeartor = 1;
          return;
        }else{
          opeartor = 2;
          return;
        }
      }
    }else{
      opeartor = 0;
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nomFocusNode = new FocusNode();
    _heightFocusNode = new FocusNode();
    _weightFocusNode = new FocusNode();
    _emailFocusNode = new FocusNode();
    _pwdFocusNode = new FocusNode();

    _nomController = new TextEditingController();
    _weightController = new TextEditingController();
    _heightController = new TextEditingController();
    _emailController = new TextEditingController();
    _pwdController = new TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nomController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _emailController.dispose();
    _pwdController.dispose();

    _nomFocusNode.dispose();
    _pwdFocusNode.dispose();
    _heightFocusNode.dispose();
    _weightFocusNode.dispose();
    _emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset('assets/images/image12.png')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: false,
                    focusNode: _nomFocusNode,
                    controller: _nomController,
                    decoration: new InputDecoration(
                      hintText: "Name",
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
                    onChanged: (val){

                    },
                    maxLines: 1,
                    validator: (value){

                    },
                    onTapOutside: (dd){
                      //_paymentFocusNode.unfocus();
                    },
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // Only numbers can be entered
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: _emailController,
                    focusNode: _emailFocusNode,
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
                    onChanged: (val){

                    },
                    maxLines: 1,
                    validator: (value){

                    },
                    onTapOutside: (dd){
                      //_paymentFocusNode.unfocus();
                    },
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // Only numbers can be entered
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: _heightController,
                    focusNode: _heightFocusNode,
                    decoration: new InputDecoration(
                      hintText: "Height",
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
                    onChanged: (val){

                    },
                    maxLines: 1,
                    validator: (value){

                    },
                    onTapOutside: (dd){
                      //_paymentFocusNode.unfocus();
                    },
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [
                    ],
                    // Only numbers can be entered
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _weightController,
                    focusNode: _weightFocusNode,
                    autofocus: false,
                    decoration: new InputDecoration(
                      hintText: "Weight",
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
                    ],
                    onChanged: (val){

                    },
                    maxLines: 1,
                    validator: (value){

                    },
                    onTapOutside: (dd){
                      _weightFocusNode.unfocus();
                    },
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // Only numbers can be entered
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: _pwdController,
                    focusNode: _pwdFocusNode,
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
                    onChanged: (val){

                    },
                    maxLines: 1,
                    validator: (value){

                    },
                    onTapOutside: (dd){
                      //_paymentFocusNode.unfocus();
                    },
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // Only numbers can be entered
                  ),
                ),
                // Add more form fields for email, phone, and last visit
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
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
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        var data = {
                          "name": _nomController.text,
                          "BMI": double.parse(_weightController.text) / (double.parse(_heightController.text) * double.parse(_heightController.text)),
                          "disease": "non",
                          "email": _emailController.text,
                          "weight": _weightController.text,
                          "height": _heightController.text,
                          "role": 1,
                          "password": _pwdController.text,
                        };
                        print(data);
                        await context.read<UserViewModel>().register(context,data).then((val){
                          if(val){
                            Navigator.of(context).pushNamed("/success");
                          }
                        });
                      }
                    },
                    child: Text('Ajouter Client'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

