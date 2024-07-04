import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Bravo!!!!",textAlign: TextAlign.center,style: TextStyle(color: Colors.green,fontSize: 25),),
            SizedBox(height: 10,),
            Text("Enregistrement Avec\n success",textAlign: TextAlign.center,),
            SizedBox(height: 20,),
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
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Ok"),
            )
          ],
        ),
      ),
    );
  }
}
