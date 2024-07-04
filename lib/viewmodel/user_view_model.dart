import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fitness/models/User.dart';
import 'package:fitness/services/CallApi.dart';
import 'package:fitness/services/general_services.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserViewModel extends ChangeNotifier {

  bool chekingEmailExist = false;
  bool updatingUser = false;
  bool isregistring = false;
  bool islogging = false;
  bool isloggingout = false;
  bool isRequestingResetPassword = false;
  bool isSendingResetPasswordCode = false;
  bool isUpdatingPassword = false;

  User user_reseting_password = new User.EmptyUser();

  Future<bool> register(BuildContext context, data) async {
    if(isregistring) return false;
    isregistring = true;
    notifyListeners();
    //final url = "http://www.omdbapi.com/?s=$keyword&apikey=YOURAPIKEYHERE";
    //final response = await http.get(url as Uri);
    try {
      final response = await CallApi().unAuthPostData(data,"register");

      print(response.body);
      if(response.statusCode == 200){
        var body = jsonDecode(response.body)["user"];
        User user = User.fromJson(body);
        isregistring = false;
        notifyListeners();
        return jsonDecode(response.body)["success"];
      }else{
        isregistring = false;
        notifyListeners();
        return false;
      }

    }on TimeoutException catch(_){
      isregistring = false;
      notifyListeners();
      return false;
    }on SocketException catch(_){
      print('no internet');
      isregistring = false;
      notifyListeners();
      return false;
    }catch(e){
      print(e);
      isregistring = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(BuildContext context,data) async {
    if(islogging) return false;
    islogging = true;
    //final url = "http://www.omdbapi.com/?s=$keyword&apikey=YOURAPIKEYHERE";
    //final response = await http.get(url as Uri);
    try {
      final response = await CallApi().unAuthPostData(data,"login");
      print(response.body);
      if(response.statusCode == 200){
        var body = jsonDecode(response.body)["user"];
        //User user = User.fromJson(body);

        print(response.body);
        await context.read<AppSharedPreferences>().setLoggingPreferences(body,jsonDecode(response.body)["token"]);
        islogging = false;
        notifyListeners();
        return jsonDecode(response.body)["success"];
      }else{
        GeneralServices.displaySnackBar(context,jsonDecode(response.body)["message"],color: Colors.red);
        islogging = false;
        notifyListeners();
        return false;
      }
    }on TimeoutException catch(_){
      islogging = false;
      notifyListeners();
      GeneralServices.displaySnackBar(context,"Error, please try again later",color: Colors.red);
      return false;
    }on SocketException catch(_){
      islogging = false;
      notifyListeners();
      GeneralServices.displaySnackBar(context,"Error, please try again later",color: Colors.red);
      return false;
    }catch(e){
      print(e);
      islogging = false;
      GeneralServices.displaySnackBar(context,"Error, please try again later",color: Colors.red);
      notifyListeners();
      return false;
    }
  }



  Future<bool> logout(BuildContext context,data) async {
    if(isloggingout) return false;
    isloggingout = true;
    //final url = "http://www.omdbapi.com/?s=$keyword&apikey=YOURAPIKEYHERE";
    //final response = await http.get(url as Uri);
    try {
      final response = await CallApi().authPostData(data,"logout");

      print(response.body);
      if(response.statusCode == 200){
        bool result = jsonDecode(response.body)["success"];

        if(result){
          await context.read<AppSharedPreferences>().clearUserPreferences();
        }
        isloggingout = false;
        notifyListeners();
        return jsonDecode(response.body)["success"];
      }else{
        GeneralServices.displaySnackBar(context,jsonDecode(response.body)["message"],color: Colors.red);
        isloggingout = false;
        notifyListeners();
        return false;
      }
    }on TimeoutException catch(_){
      isloggingout = false;
      notifyListeners();
      return false;
    }on SocketException catch(_){
      isloggingout = false;
      notifyListeners();
      return false;
    }catch(e){
      print(e);
      isloggingout = false;
      notifyListeners();
      return false;
    }
  }


}
