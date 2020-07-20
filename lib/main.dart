import 'package:deskpixel/pages/splashscreen.dart';
import 'package:deskpixel/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
   return ChangeNotifierProvider(
     create:(_)=>ThemeNotifier(),
     child: Consumer<ThemeNotifier>(
       builder: (context,ThemeNotifier notifier,child){
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           title: "Deskpixel",
           color: Color.fromARGB(255, 40, 63, 77),
           theme: notifier.darktheme?ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(
               builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
              backgroundColor:Color.fromARGB(255, 16, 39, 51),
              canvasColor:Color.fromARGB(255, 16, 39, 51),
              cardColor:Color.fromARGB(255, 40, 63, 77),
              fontFamily: "GoogleSans",
              appBarTheme: AppBarTheme(
                color: Color.fromARGB(255, 16, 39, 51)
              ),
              textTheme: TextTheme(
                title:TextStyle(color: Colors.white),
                subtitle: TextStyle(color: Colors.white),
                headline: TextStyle(color: Colors.white),
                body1: TextStyle(color: Colors.white),
                caption: TextStyle(color: Colors.white),
                body2: TextStyle(color: Colors.white),
                display1: TextStyle(color: Colors.white),
                display2: TextStyle(color: Colors.white),
                display3: TextStyle(color: Colors.white),
                display4: TextStyle(color: Colors.white),
            ),)
           :ThemeData(
             pageTransitionsTheme: PageTransitionsTheme(
               builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
             canvasColor: Colors.white,
             scaffoldBackgroundColor: Colors.white,
             fontFamily: "GoogleSans",
             appBarTheme: AppBarTheme(
                color: Colors.white
              ),
             ),
           home: SplashScreen(notifier.darktheme)
         );
       }
       ),
   );
  }
}






