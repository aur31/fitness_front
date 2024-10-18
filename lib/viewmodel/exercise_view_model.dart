import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fitness/services/constants.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'package:fitness/models/Exercise.dart';
import 'package:fitness/services/CallApi.dart';
import 'package:fitness/services/general_services.dart';
import 'package:flutter/material.dart';


class ExerciseViewModel extends ChangeNotifier {

  bool updatingUser = false;
  bool loadingExercise = false;
  bool isregistringExercise = false;
  bool isregistring = false;

  List<Exercise> exercises = [];
  List<Exercise> catExercises = [];

  Future<bool> getExercise()async{
    if(loadingExercise) return false;
    loadingExercise = true;
    exercises.clear();
    notifyListeners();
    try{
      print('comment above');
      final response = await CallApi().authGetData("exercises");

      print('comment below');
      print(response.body);
      //print(response.headers);
      if(response.statusCode == 200){
        print("inside");
        Iterable list = jsonDecode(response.body);
        print(list);

        exercises.addAll(List<Exercise>.from(list.map((e) => Exercise.fromJson(e))));

        loadingExercise = false;
        notifyListeners();
        return true;
      }else{
        print(response.headers);
        print(response.body);
        print(response.statusCode);
        loadingExercise = false;
        notifyListeners();
        return false;
      }
    }catch(e){
      print(e.toString()+'gfhgfhgfhg');
      loadingExercise = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getCategoryExercise({required String id_cat})async{
    if(loadingExercise) return false;
    loadingExercise = true;
    catExercises.clear();
    notifyListeners();
    try{
      print('comment above');
      final response = await CallApi().authGetData("category/exercise/${id_cat}");

      print('comment below');
      print(response.body);
      //print(response.headers);
      if(response.statusCode == 200){
        print("inside");
        Iterable list = jsonDecode(response.body);
        print(list);

        catExercises.addAll(List<Exercise>.from(list.map((e) => Exercise.fromJson(e))));

        loadingExercise = false;
        notifyListeners();
        return true;
      }else{
        print(response.headers);
        print(response.body);
        print(response.statusCode);
        loadingExercise = false;
        notifyListeners();
        return false;
      }
    }catch(e){
      print(e.toString()+'gfhgfhgfhg');
      loadingExercise = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerExercise(BuildContext context,File document,var data)async{
    if(isregistringExercise) return false;
    isregistringExercise = true;
    notifyListeners();
    try{
      print('1');
      var request = http.MultipartRequest('POST', Uri.parse(CallApi.url+"exercises"));
      request.headers.addAll(
          {
            'Accept': 'application/json',
            'Authorization': 'Bearer '+(await CallApi().getToken())!,
            'Access-Control-Allow-Origin': "*",
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Headers': "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            'Access-Control-Allow-Methods': "POST, OPTIONS"
          }
      );
      request.fields.addAll(data);
      print('2');


      //print(pdfFiles[i].mimeType);
      print(document.runtimeType);
      //print(File(images[i].path).runtimeType);
      //print(basename(images[i].path.split("/").last));

      print(document.path);
      request.files.add(
          http.MultipartFile.fromBytes(
            'video',
            await document.readAsBytes(),
            filename: ActualPlatform.platform() == 3 ? Path.basename(document.path) : Path.basename("${DateTime.now().millisecondsSinceEpoch}.${document.path}"),
          )
      );


      print('4');
      //print(request.files.length);
      print(CallApi.url+"exercises");
      //send
      var response = await request.send().timeout(Duration(minutes: 10));

      print('5');
      print(response.statusCode);
      print(response.headers);
      print(response.request);



      var responsed = await http.Response.fromStream(response);
      print(jsonDecode(responsed.body));
      //print(jsonDecode(responsed.body)["docs"]);
      print('6');


      if(response.statusCode == 200){

        print("yy");
        //GeneralServices.displaySnackBar(context, jsonDecode(responsed.body)["message"]);
        print(responsed.headers);
        print(responsed.statusCode);
        //print(responsed.body);
        isregistringExercise = false;
        notifyListeners();
        //Navigator.of(context).pushNamed("/payment_succeed");
        return true; //jsonDecode(responsed.body)["success"];
      }else{
        GeneralServices.displaySnackBar(context, jsonDecode(responsed.body)["message"]);
        print(responsed.headers);
        print(responsed.statusCode);
        print(responsed.body);
        isregistringExercise = false;
        notifyListeners();
        //Navigator.of(context).pushNamed("/payment_failed");
        return jsonDecode(responsed.body)["success"];
      }

    }catch(e){
      print(e.toString()+'gfhgfhgfhg');
      GeneralServices.displaySnackBar(context, "Error translating the file");
      isregistringExercise = false;
      notifyListeners();
      //Navigator.of(context).pushNamed("/payment_failed");
      return false;
    }

  }

  Future<bool> registerdd(BuildContext context, data) async {
    if(isregistring) return false;
    isregistring = true;
    notifyListeners();
    //final url = "http://www.omdbapi.com/?s=$keyword&apikey=YOURAPIKEYHERE";
    //final response = await http.get(url as Uri);
    try {
      final response = await CallApi().unAuthPostData(data,"exercises");

      print(response.body);
      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        Exercise exercise = Exercise.fromJson(body);
        exercises.add(exercise);

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
