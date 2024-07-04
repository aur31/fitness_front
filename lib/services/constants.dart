import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//MY BREAKPOINTS ARE
int mobileBreakPoint = 650;
int tabletteBreakPoint = 650;
int desktopBreakPoint = 1024;

class ActualPlatform {
  static late bool isAndroid;
  static late bool isIOS;
  //bool? isWeb;
  void init(BuildContext context){
    isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    isAndroid = Theme.of(context).platform == TargetPlatform.android;
  }

  //RETURN 1 FOR ANDROID, 2 FOR IOS AND 3 FOR WEB
  static int platform(){
    try{
      if(Platform.isAndroid) return 1;
      if(Platform.isIOS) return 2;
    }catch(e){
      if(kIsWeb) return 3;
    }
    return 0;
  }
}


class AppTextStyle {
  late BuildContext context;
  AppTextStyle({required this.context});
  TextStyle getT1(){
    return TextStyle(fontSize: context.read<Responsiveness>().safeBlockHorizontal * 10,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic);
  }
  TextStyle getT2(){
    return TextStyle(fontSize: context.read<Responsiveness>().safeBlockHorizontal * 7,fontWeight: FontWeight.w600,);
  }
  TextStyle getT3(){
    return TextStyle(fontSize: context.read<Responsiveness>().safeBlockHorizontal * 4);
  }
  TextStyle getT4(){
    return TextStyle(fontSize: context.read<Responsiveness>().safeBlockHorizontal * 2,fontWeight: FontWeight.w600);
  }
  TextStyle getKstyleDevinette(){
    return TextStyle(fontSize: context.read<Responsiveness>().safeBlockHorizontal * 5);
  }
}

class AppColors {
  static const Color blue = Color(0xFF306eFF);
  static const Color ligntBlue = Color(0xFF4985FD);
  static const Color darkBlue = Color(0xFF1046B3);
  static const Color grey = Color(0xFFF4F5F7);
  static const Color blackLight = Color(0xFF2D3243);
  static const Color black = Color(0xff000000);
  static const Color amber = Color(0xFFFFB200);
  static const Color timerColorGood = Color(0xFF00FF00);
  static const Color timerColorMedium = Color(0xFFFFBf00);
  static const Color timerColorHigh = Color(0xFFFF0000);


  static const Color blueblack = Color(0xFF150041);
  static const Color dirtywhite = Color(0xFFC4C4C4);

}

class Responsiveness extends ChangeNotifier {
  late MediaQueryData _mediaQueryData;
  late double screenWidth;
  late double screenHeight;
  late double blockSizeHorizontal;
  late double blockSizeVertical;

  //NOW WE WANNA GET THE SPACE TAKEN BY THE SafeArea
  late double safeAreaHorizontal;
  late double safeAreaVertical;
  late double safeBlockHorizontal;
  late double safeBlockVertical;

  Future<void> init(BuildContext context)async{
      _mediaQueryData = MediaQuery.of(context);
      screenWidth = _mediaQueryData.size.width;
      screenHeight = _mediaQueryData.size.height;
      blockSizeHorizontal = screenWidth / 100;
      blockSizeVertical = screenHeight / 100;

      safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
      safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

      safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
      safeBlockVertical = (screenHeight - safeAreaVertical) / 100;
  }
}

class imageSizing {

}