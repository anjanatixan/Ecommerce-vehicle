import 'dart:ui';

import 'package:flutter/material.dart';

import 'navigation.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Container(
          color: Colors.white.withOpacity(0.1),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Stack(
                  children: [spinkit],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      );
    },
  );
}
BuildContext getContext() {
  return NavigationService.navigatorKey.currentContext!;
}

showToast(BuildContext context, String message, Color color, Color textcolor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    dismissDirection: DismissDirection.down,
    content: Text(
      message,
      style: TextStyle(color: textcolor, ),
    ),
    behavior: SnackBarBehavior.fixed,
    duration: Duration(seconds: 3),
  ));
}

getWidth(BuildContext context) => MediaQuery.of(context).size.width;
getHeight(BuildContext context) => MediaQuery.of(context).size.height;