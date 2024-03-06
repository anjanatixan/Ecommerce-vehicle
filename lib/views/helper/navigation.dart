
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NavigationUtils {
  static Future<dynamic> goNext(BuildContext context, Widget screen,
      {bool isFinish = false}) async {
    if (isFinish) {
      return await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => screen));
    } else {
      return await Navigator.push(
          // context, MaterialPageRoute(builder: (context) => screen)
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => screen,
              transitionDuration: Duration(microseconds: 0),
              transitionsBuilder:
                  ((context, animation, secondaryAnimation, child) => child)));
    }
  }

  static goNextFinishAll(
    BuildContext context,
    Widget screen,
  ) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false);
  }

  static goBack(BuildContext context, {dynamic data}) {
    Navigator.pop(context);
  }
}

final spinkit = SpinKitCircle(
  color:Colors.white,
);

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}