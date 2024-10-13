import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fitness/models/Encouragement.dart';
import 'package:fitness/models/User.dart';
import 'package:fitness/services/CallApi.dart';
import 'package:fitness/services/general_services.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EncouragementViewModel extends ChangeNotifier {

  bool updatingUser = false;
  bool loadingEncouragement = false;
  bool isregistring = false;

  List<Encouragement> encouragements = [];

  Future<bool> getEncouragement()async{
    if(loadingEncouragement) return false;
    loadingEncouragement = true;
    encouragements.clear();
    notifyListeners();
    try{
      print('comment above');
      final response = await CallApi().authGetData("encouragements");

      print('comment below');
      print(response.body);
      //print(response.headers);
      if(response.statusCode == 200){
        print("inside");
        Iterable list = jsonDecode(response.body);
        print(list);

        encouragements.addAll(List<Encouragement>.from(list.map((e) => Encouragement.fromJson(e))));

        loadingEncouragement = false;
        notifyListeners();
        return true;
      }else{
        print(response.headers);
        print(response.body);
        print(response.statusCode);
        loadingEncouragement = false;
        notifyListeners();
        return false;
      }
    }catch(e){
      print(e.toString()+'gfhgfhgfhg');
      loadingEncouragement = false;
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
      final response = await CallApi().unAuthPostData(data,"encouragements");

      print(response.body);
      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        Encouragement encouragement = Encouragement.fromJson(body);
        encouragements.add(encouragement);

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



}
