import 'package:deskpixel/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deskpixel/pages/about.dart';
import 'package:deskpixel/pages/premium.dart';
import 'package:deskpixel/pages/trendingpage.dart';
import 'package:deskpixel/pages/searchedpage.dart';
import 'package:deskpixel/widgets/categorytile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_admob/firebase_admob.dart';

class LandingPage extends StatefulWidget {
   bool darktheme;
   LandingPage(this.darktheme);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  TextEditingController t=new TextEditingController();

  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarIconBrightness: widget.darktheme?Brightness.light:Brightness.dark),
      child: Scaffold(
       resizeToAvoidBottomInset: false,
       drawer:Drawer(
         child:Column(
           children:<Widget>[
            Container(
              height: 220,
              width:  double.infinity,
              decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                alignment: Alignment.topLeft,
                fit: BoxFit.cover,
                image: AssetImage("Assets/Images/drawerimg.jpg")
                )
            ),
            ),
            SizedBox(height:10),
             ListTile(
               enabled: true,
              leading:Icon(Icons.trending_up,color: widget.darktheme?Colors.white70:Colors.black54,),
              title: Text("Trending Clicks",
                style: TextStyle( fontFamily: "GoogleSans",),
               textScaleFactor: 0.8,
              ),
               onTap:()=>{
                Navigator.of(context).push(
                 MaterialPageRoute<Null>(
                   builder:(BuildContext context){
                     return TrendingPage(widget.darktheme);
              }))},
               ),

             Container(

                 child: ListTile(
                 leading:Icon(Icons.free_breakfast,color: widget.darktheme?Colors.white70:Colors.black54,),
                 title: Text("Hot Wallpapers",
                  style: TextStyle( fontFamily: "GoogleSans",),
                  textScaleFactor: 0.8,
                 ),
                enabled: true,
                onTap:()=>{

                   Navigator.of(context).push(
                    MaterialPageRoute<Null>(
                      builder:(BuildContext context){
                        return WallScreen(widget.darktheme);
                 }))
                 },
                ),
             ),
              Container(

                  child: Consumer<ThemeNotifier>(
                  builder: (context,notifier,child)=>SwitchListTile(
                    activeColor: Colors.cyan,
                    value: notifier.darktheme, onChanged:(v) {notifier.toggleTheme();widget.darktheme=notifier.darktheme;},
                    title: Text("DarkMode",style: TextStyle( fontFamily: "GoogleSans",), textScaleFactor: 0.8,),
                    )
                ),
              ),

             Container(
                  child: ListTile(
                  leading:Icon(Icons.account_circle,color: widget.darktheme?Colors.white70:Colors.black54,),
                   title: Text("About",
                      style: TextStyle( fontFamily: "GoogleSans",),
                      textScaleFactor: 0.8,
                  ),
                 onTap:()=>{
                     Navigator.of(context).push(
                     MaterialPageRoute<Null>(
                     builder:(BuildContext context){
                     return About(widget.darktheme);
                  }))},
               ),
             ),
             Expanded(
               flex: 1,
               child:Padding(padding: EdgeInsets.all(8))
               ),
               Text("VERSION 1.0.2",
                textScaleFactor: 0.8,
               )
           ]
         ),
       ),


      body:Stack(
        children: <Widget>[
          Container(
            height:double.infinity,
            width:double.infinity,
            child: SvgPicture.asset(
              'Assets/Images/background.svg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          new Padding(padding: EdgeInsets.all(height/15),
          ),
          Padding(
            padding: const EdgeInsets.only(left:32.0,top: 32),
            child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Hi There ! 😍",
                  textAlign: TextAlign.start,
                  textScaleFactor: 0.8,
                  style: TextStyle(
                    fontSize:33,
                    fontWeight: FontWeight.bold,

                   ),),
                  new Padding(padding: EdgeInsets.all(5),),
                  Row(
                    children: <Widget>[
                      new Text("Welcome To Desk",
                      textAlign: TextAlign.start,
                      textScaleFactor: 0.8,
                      style: TextStyle(
                        fontSize:33,
                        fontWeight: FontWeight.bold,
                       ),),
                       new Text("Pixel",
                      textAlign: TextAlign.start,
                      textScaleFactor: 0.8,
                      style: TextStyle(
                        fontSize:33,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                       ),),
                    ],
                  ),
                ],
              )
            ],
            ),
          ),
            new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height/30),),
            new Row(
          mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Center(
               child: Card(
                 color:Color.fromARGB(255, 40, 63, 77),
                 elevation: 0,
                 shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                 child: Container(
                   width: MediaQuery.of(context).size.width/1.16,
                   height: MediaQuery.of(context).size.height/17,
                   child: Center(
                     child: TextField(
                        controller: t,
                      onSubmitted:(t1)=> {Navigator.of(context).push(
                       MaterialPageRoute<Null>(
                       builder:(BuildContext context){
                       return SearchedPage(t.text,widget.darktheme);
                       })),
                       },
                       style: TextStyle(color:Colors.white70),
                       decoration: InputDecoration(prefixIcon: Icon(Icons.search,color:Colors.white70,),
                       hintText: "Search wallpaper type etc..",border: InputBorder.none,
                       hintStyle: TextStyle(color: Colors.white70,
                       fontSize: 16),),
                     ),
                   ),
                 ),
               ),
             )
           ],
            ),
             new Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height/25),),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right:18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CategoryTile(0,widget.darktheme),
                          CategoryTile(1,widget.darktheme),
                          CategoryTile(2,widget.darktheme),
                        ],
                      ),
                      SizedBox(height:15),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CategoryTile(3,widget.darktheme),
                          CategoryTile(4,widget.darktheme),
                          CategoryTile(5,widget.darktheme),
                        ],
                      ),
                       SizedBox(height:15),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CategoryTile(6,widget.darktheme),
                          CategoryTile(7,widget.darktheme),
                          Container(
                            height:height/20,
                            width: width/5,
                          )
                        ],
                      )
                    ],
                  ),
                )
                )
             ],
            ),
        ],
      ),

        floatingActionButton: FloatingActionButton(
          child: Builder(
            builder: (BuildContext context){
              return IconButton(icon: Icon(Icons.keyboard_arrow_left), onPressed:()=>Scaffold.of(context).openDrawer(),);
            },
            ),
          backgroundColor: Colors.red, onPressed: () {  },
          ),
        ),
    );
  }
}