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
  bool loadingUser = false;
  bool isregistring = false;
  bool islogging = false;
  bool isloggingout = false;
  bool isRequestingResetPassword = false;
  bool isSendingResetPasswordCode = false;
  bool isUpdatingPassword = false;

  List<User> users = [];

  Future<bool> getUsers()async{
    if(loadingUser) return false;
    loadingUser = true;
    users.clear();
    notifyListeners();
    try{
      print('comment above');
      final response = await CallApi().authGetData("users");

      print('comment below');
      print(response.body);
      //print(response.headers);
      if(response.statusCode == 200){
        print("inside");
        Iterable list = jsonDecode(response.body);
        print(list);

        users.addAll(List<User>.from(list.map((e) => User.fromJson(e))));

        loadingUser = false;
        notifyListeners();
        return true;
      }else{
        print(response.headers);
        print(response.body);
        print(response.statusCode);
        loadingUser = false;
        notifyListeners();
        return false;
      }
    }catch(e){
      print(e.toString()+'gfhgfhgfhg');
      loadingUser = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(BuildContext context, data) async {
    if(isregistring) return false;
    isregistring = true;
    notifyListeners();
    //final url = "http://www.omdbapi.com/?s=$keyword&apikey=YOURAPIKEYHERE";
    //final response = await http.get(url as Uri);
    try {
      final response = await CallApi().unAuthPostData(data,"register/user");

      print(response.body);
      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        User user = User.fromJson(body);

        users.add(user);

        isregistring = false;
        notifyListeners();
        return true;
      }else{
        isregistring = false;
        notifyListeners();
        return false;
      }

    }on TimeoutException catch(_){
      isregistring = false;
      notifyListeners();
      return false;
    }on SocketException catch(e){
      print('no internet');
      print(e.message);
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
