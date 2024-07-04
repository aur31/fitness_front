import 'dart:math';

import 'package:fitness/services/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralServices {

  static void dashBoardDecider(BuildContext context){
    if(context.read<AppSharedPreferences>().getLoginStatus){
      if(context.read<AppSharedPreferences>().user!.role == 0){
        Navigator.of(context).pushNamed("/admin");
      }
      if(context.read<AppSharedPreferences>().user!.role == 1){
        Navigator.of(context).pushNamed("/vente");
      }
      if(context.read<AppSharedPreferences>().user!.role == 2){
        Navigator.of(context).pushNamed("/commercial");
      }
      if(context.read<AppSharedPreferences>().user!.role == 3){
        Navigator.of(context).pushNamed("/client");
      }
    }else{
      Navigator.of(context).pushNamed("/login");
    }
  }
  static void displaySnackBar(BuildContext context, String message,
      {Color color = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
            child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: color),
        )),
        dismissDirection: DismissDirection.endToStart,
      ),
    );
  }

  static Future<TimeOfDay?> displayTimePicker(BuildContext context) async {
    return await showTimePicker(
      context: context,
      helpText: "Enter Time in 12h format",
      initialTime: TimeOfDay(hour: 06, minute: 00),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
  }


  static String pluralChecker(int value) {
    return value > 1 ? "s" : "";
  }


  static String spacer(String value) {
    String result;
    result = value.isEmpty ? "" : " | ";
    return result;
  }

  static MyTextScaleFactor(BuildContext context,
      {double minTextFactor = 0.8, double maxTextFactor = 1.5}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextFactor;
    return max(minTextFactor, min(val, maxTextFactor));
  }
}
