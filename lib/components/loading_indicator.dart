import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart' as loading;

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Container(
        height: 100,
        width: 100,
        child: loading.LoadingIndicator(
            indicatorType: loading.Indicator.ballTrianglePath, /// Required, The loading type of the widget
            colors: const [Colors.green,Colors.red,Colors.blue],       /// Optional, The color collections
            strokeWidth: 5,                     /// Optional, The stroke of the line, only applicable to widget which contains line
            backgroundColor: Colors.transparent,      /// Optional, Background of the widget
            pathBackgroundColor: Colors.transparent   /// Optional, the stroke backgroundColor,
        ),
      )
    );
  }
}
