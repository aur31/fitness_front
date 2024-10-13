import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'sharedPreferences.dart';


class CallApi{
  //final String _url = "http://192.168.1.23/api/";
  final int timeOut = 30;
  late String token;
  AppSharedPreferences appSharedPreferences = AppSharedPreferences();

  static final String url = "http://192.168.60.98:8080/api/";


  final Map<String,String> roots = {
    "logout":"logout",
    "login":"login",
    "register":"register",
    "search":"search",
  };

  Future<http.Response> authPostData(data,apiUrl) async {
    token = (await getToken())!;
    //var fullUrl = _url + apiUrl + await _getToken();
    var fullUrl = url + apiUrl;
  //print(fullUrl);
    print('PAGE URL IS $fullUrl');

    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _authHeader()
    ).timeout(Duration(seconds: timeOut));
  }

  Future<http.Response> authPutData(data,apiUrl) async {
    token = (await getToken())!;
    //print('sdsdsdsdsdsdsds');
    //print(token);
    //print(appSharedPreferences.token);
    //var fullUrl = _url + apiUrl + await _getToken();
    var fullUrl = url + apiUrl;
  //print(fullUrl);
    print('PAGE URL IS $fullUrl');

    return await http.put(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _authHeader()
    ).timeout(Duration(seconds: timeOut));
  }

  Future<http.Response> deleteData(data,apiUrl) async {
    token = (await getToken())!;
    //print('sdsdsdsdsdsdsds');
    //print(token);
    //print(appSharedPreferences.token);
    //var fullUrl = _url + apiUrl + await _getToken();
    var fullUrl = url + apiUrl;
  //print(fullUrl);
    print('PAGE URL IS $fullUrl');

    return await http.delete(
            Uri.parse(fullUrl),
            body: jsonEncode(data),
            headers: _authHeader()
    ).timeout(Duration(seconds: timeOut));
  }

  Future<http.Response> unAuthPostData(data,apiUrl) async {
    //var fullUrl = _url + apiUrl + await _getToken();
    var fullUrl = url + apiUrl;
    //print(fullUrl);
    print('PAGE URL IS $fullUrl');

    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _unAuthHeader()
    ).timeout(Duration(seconds: timeOut));
  }

  Future<http.Response> authGetData(apiUrl) async {
    token = (await getToken())!;
    var fullUrl = url + apiUrl;// + await _getToken();
    //print(fullUrl);
    print('PAGE URL IS $fullUrl');

    return await http.get(
      Uri.parse(fullUrl),
      headers: _authHeader()
    ).timeout(Duration(seconds: timeOut));
  }

  Future<http.Response> unAuthGetData(apiUrl) async {
    var fullUrl = url + apiUrl;
    //print("GETTING THE API ");
    //print(fullUrl);
    print('PAGE URL IS $fullUrl');

    return await http.get(
        Uri.parse(fullUrl),
        headers: _unAuthHeader()
    ).timeout(Duration(seconds: timeOut));
  }



  Future<http.StreamedResponse?> uploadImage(File imageFile,user_id) async {
    // open a bytestream
    String? path;
    var stream = new http.ByteStream(Stream.castFrom(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // string to uri
    var uri = Uri.parse(url+"upload-profil-image/"+user_id);
    print(uri.toString());
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = 'Bearer '+(await getToken())!;
    //request.headers['Content-type'] = 'application/json';
    //request.headers['Accept'] = 'application/json';
    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length, filename: basename(imageFile.path));
    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    /*print(response.statusCode);
    if(response.statusCode == 200){
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      print(map["message"]);
      print(map["filed"]);
      print(map["file"]);
      print(map["path"]);
      path = map["path"];
    }else{
      print("error uploading image");
    }*/

    return response;
    // listen for response
    /*response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });*/
  }

  _unAuthHeader() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  Future<String?> getToken()async{
    await appSharedPreferences.checkIfLogIn();
    //SharedPreferences localStorage = await SharedPreferences.getInstance();
    //return await localStorage.getString('token');
    //print('hohohohohohohohohohhoho'+appSharedPreferences.token ?? 'dd');
    return appSharedPreferences.token;
  }

  _authHeader()=> {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization': 'Bearer ${appSharedPreferences.token}',
  };



  /*  //SharedPreferences localStorage = await SharedPreferences.getInstance();
    //var token = localStorage.getString("token");
    //return "/?token=${AppSharedPreferences.token}";
    return '/'+AppSharedPreferences.token;
    //return "/$token";
  }*/

}