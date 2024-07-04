import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fitness/models/Sport.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:path/path.dart' as Path;

import '../services/CallApi.dart';
import '../services/constants.dart';
import '../services/general_services.dart';
import 'package:http/http.dart' as http;


class SportViewModel extends ChangeNotifier{
  bool loadingSPorts = false;
  bool isAddingEmploye = false;
  bool isregistring = false;

  List<Sport> sports = [];

  Future<bool> getGrille(BuildContext context)async{
    if(loadingSPorts) return false;
    loadingSPorts = true;
    sports.clear();
    notifyListeners();
    try{
      print('comment above');
      final response = await CallApi().unAuthGetData("sports");

      print('comment below');
      print(response.body);
      //print(response.headers);
      if(response.statusCode == 200){
        //print(User_Devinette.fromJson(jsonDecode(response.body)));
        Iterable list = jsonDecode(response.body)["data"];

        sports = List<Sport>.from(list.map((e) => Sport.fromJson(e)));
        print(sports.length);
        loadingSPorts = false;
        notifyListeners();
        return true;
      }else{
        print(response.headers);
        print(response.body);
        print(response.statusCode);
        loadingSPorts = false;
        notifyListeners();
        return false;
      }
    }catch(e){

      print(e.toString()+'gfhgfhgfhg');
      loadingSPorts = false;
      notifyListeners();
      return false;
    }

  }


  Future<bool?> ajouterProduitGrille(BuildContext context,File image,Map<String, String> data)async{
    if(isregistring) return false;
    isregistring = true;
    notifyListeners();
    try{
      print('1');
      //final form = FormData
      //create multipart request
      var request = http.MultipartRequest('POST', Uri.parse(CallApi.url+"ajouter_grille"));
      //request.headers['Authorization'] = 'Bearer '+(await CallApi().getToken())!;
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
      print(image.runtimeType);
      //print(File(images[i].path).runtimeType);
      //print(basename(images[i].path.split("/").last));

      print(image.path);
      request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            await image.readAsBytes(),
            //new http.ByteStream(Stream.castFrom(File(images[i].path).openRead())),
            //await images[i].length(),
            //File(images[i].path).openRead(),
            //await File(images[i].path).length(),
            //filename: images[i].name,
            filename: ActualPlatform.platform() == 3 ? Path.basename(image.path) : Path.basename("${DateTime.now().millisecondsSinceEpoch}.${image.path}"),
          )
      );


      print('4');
      //print(request.files.length);
      print(CallApi.url+"print/documents");
      //send
      var response = await request.send().timeout(Duration(minutes: 10));

      print('5');
      print(response.statusCode);
      print(response.headers);



      var responsed = await http.Response.fromStream(response);
      print(jsonDecode(responsed.body));
      print(jsonDecode(responsed.body)["docs"]);
      print('6');


      if(response.statusCode == 200){

        GeneralServices.displaySnackBar(context, jsonDecode(responsed.body)["message"]);
        print(responsed.headers);
        print(responsed.statusCode);
        print(responsed.body);
        var body = jsonDecode(responsed.body)["grille"];
        Sport grille = Sport.fromJson(body);

        sports.add(grille);
        isregistring = false;
        notifyListeners();
        Navigator.of(context).pushNamed("/success");
        return jsonDecode(responsed.body)["success"];
      }else{
        GeneralServices.displaySnackBar(context, jsonDecode(responsed.body)["message"]);
        print(responsed.headers);
        print(responsed.statusCode);
        print(responsed.body);
        isregistring = false;
        notifyListeners();
        //Navigator.of(context).pushNamed("/payment_failed");
        return jsonDecode(responsed.body)["success"];
      }

    }catch(e){
      print(e.toString()+'gfhgfhgfhg');
      isregistring = false;
      notifyListeners();
      Navigator.of(context).pushNamed("/payment_failed");
      return false;
    }

  }


}