import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
class About extends StatelessWidget {
  var darktheme;
  About(this.darktheme);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    child:Scaffold(
      appBar: AppBar(
        elevation: 0,
      title:Text("About",
         textScaleFactor: 0.8,
         style:TextStyle(color:darktheme?Colors.white:Colors.black)
      ),
      brightness: darktheme?Brightness.dark:Brightness.light,
      iconTheme: IconThemeData(
        color:darktheme?Colors.white:Colors.black
      ),
    ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SvgPicture.asset(
                      'Assets/Images/Astronaut.svg',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      height: screenWidth * 0.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      "Dhananjay Sahu",
                      style: TextStyle( fontFamily: "GoogleSans",fontSize: 25),
                       textScaleFactor: 0.8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      bottom: 10.0,
                      top: 10.0,
                    ),
                    child: Text(
                      "Android Developer | Flutter Developer",

                      textAlign: TextAlign.center,

                       textScaleFactor: 0.8,
                      style: TextStyle(
                        fontFamily: "GoogleSans",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      left: 25.0,
                      right: 25.0,
                    ),
                    child: SizedBox(
                      height: 1.0,
                      child: Container(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      bottom: 10.0,
                      top: 10.0,
                    ),
                    child: Text(
                      'Follow me on',
                       textScaleFactor: 0.8,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "GoogleSans",
                        color:Color(0xFF6C63FF),
                        wordSpacing: 2,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 10.0,
                      top: 5.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                             if (await canLaunch("https://www.instagram.com/dhananjaysahu79/"))
                               await launch('https://www.instagram.com/dhananjaysahu79/');
                              else
                                throw "link not found";
                          },
                          child: SvgPicture.asset(
                            'Assets/Images/instagram.svg',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            height: screenWidth * 0.12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            if (await canLaunch("https://www.linkedin.com/in/dhananjay-sahu-525b1b1a1/"))
                              await  launch('https://www.linkedin.com/in/dhananjay-sahu-525b1b1a1/');
                              else
                                throw "link not found";
                          },
                          child: SvgPicture.asset(
                            'Assets/Images/linkedin.svg',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            height: screenWidth * 0.12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                             if (await canLaunch("https://github.com/dhananjaysahu79"))
                            launch('https://github.com/dhananjaysahu79');
                             else
                                throw "link not found";
                          },
                          child: Container(
                            height: screenWidth * 0.12,
                            width: screenWidth * 0.12,
                            decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("Assets/Images/github.png"),fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            ),

                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("SOURCE CODE OF THIS APP: ",textScaleFactor: 0.8,),
                  SizedBox(height:3),
                  InkWell(
                    onTap:()async{
                          if (await canLaunch("https://github.com/dhananjaysahu79/wallpaperApp"))
                            await  launch('https://github.com/dhananjaysahu79/wallpaperApp');
                            else
                              throw "link not found";
                        },
                    child: Text("https://github.com/dhananjaysahu79/wallpaperApp",style: TextStyle(color: Colors.blue),))
                ],
            ),
              ),
          )
        ],
      ),
     )
    );
  }
}