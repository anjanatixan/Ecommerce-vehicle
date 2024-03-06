import 'package:ecommerce/views/provider/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'views/bottomBar.dart';
import 'views/helper/navigation.dart';
import 'views/provider/bottomNavBarProvider.dart';
import 'views/provider/cartProvider.dart';

void main() {
   runApp(MultiProvider(
    providers: [
     ChangeNotifierProvider(create: ((context) => BottomNavigationBarProvider())),
     ChangeNotifierProvider(create: ((context) => CategoryProvider())),
     ChangeNotifierProvider(create: ((context) => CartProvider()))
      
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 740),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            home: BottomBar());
      },
    );
  }
}

