import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fitness/models/Encouragement.dart';
import 'package:fitness/models/User.dart';
import 'package:fitness/models/sport_category.dart';
import 'package:fitness/services/CallApi.dart';
import 'package:fitness/services/general_services.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SportCategoryViewModel extends ChangeNotifier {

  bool updatingUser = false;
  bool loadingSportCategories = false;
  bool isregistring = false;

  List<SportCategory> sportCategories = [];

  Future<bool> getSportCategory()async{
    if(loadingSportCategories) return false;
    loadingSportCategories = true;
    sportCategories.clear();
    notifyListeners();
    try{
      print('comment above');
      final response = await CallApi().authGetData("sport-categories");

      print('comment below');
      print(response.body);
      //print(response.headers);
      if(response.statusCode == 200){
        print("inside");
        Iterable list = jsonDecode(response.body);
        print(list);

        sportCategories.addAll(List<SportCategory>.from(list.map((e) => SportCategory.fromJson(e))));

        loadingSportCategories = false;
        notifyListeners();
        return true;
      }else{
        print(response.headers);
        print(response.body);
        print(response.statusCode);
        loadingSportCategories = false;
        notifyListeners();
        return false;
      }
    }catch(e){
      print(e.toString()+'gfhgfhgfhg');
      loadingSportCategories = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerSportCategory(BuildContext context, data) async {
    if(isregistring) return false;
    isregistring = true;
    notifyListeners();
    //final url = "http://www.omdbapi.com/?s=$keyword&apikey=YOURAPIKEYHERE";
    //final response = await http.get(url as Uri);
    try {
      final response = await CallApi().authPostData(data,"sport-categories");

      print(response.body);
      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        SportCategory sportCategory = SportCategory.fromJson(body);
        sportCategories.add(sportCategory);

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
