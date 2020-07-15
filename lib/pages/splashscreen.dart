import 'package:deskpixel/pages/landingpage.dart';
import 'package:deskpixel/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  var darktheme;
  SplashScreen(this.darktheme);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    changeScreen();
  }
   Future changeScreen() async {
   try{
   final res= await InternetAddress.lookup('google.com');
   if (res.isNotEmpty && res[0].rawAddress.isNotEmpty){
      await Future.delayed(const Duration(seconds: 2),(){
      Navigator.of(context).pushReplacement(
      MaterialPageRoute<Null>(
      builder:(BuildContext context){
      return Consumer<ThemeNotifier>(
        builder: (context,notifier,child)=>LandingPage(notifier.darktheme));
    }));
   });
   }

   } on SocketException catch(_){
      changeScreen();
   }
   }
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness: widget.darktheme?Brightness.light:Brightness.dark),
      child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("Assets/Images/ic_launcher.png")
                        )
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                   CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                      backgroundColor: Colors.deepPurple,
                    ),
                    Text("Loading....",style: TextStyle(fontSize: 14,letterSpacing: 2),)
                  ],
                ),
              )
            ],
          )
        ],
      ),
      ),
    );
  }
}