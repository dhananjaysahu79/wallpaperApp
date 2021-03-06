import 'package:deskpixel/pages/fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage/provider.dart';



class WallScreen extends StatefulWidget {
   var darktheme;
   WallScreen(this.darktheme);
  @override
  _WallScreenState createState() => new _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
      title:Text("HOTS",
         textScaleFactor: 0.8,
         style:TextStyle(color:widget.darktheme?Colors.white:Colors.black)
      ),
      brightness: widget.darktheme?Brightness.dark:Brightness.light,
      iconTheme: IconThemeData(
        color:widget.darktheme?Colors.white:Colors.black
      ),
    ),
     body: StreamBuilder<QuerySnapshot>(
       stream:Firestore.instance.collection("your collection id goes here").snapshots(),
       builder:(BuildContext context ,AsyncSnapshot <QuerySnapshot>snapshot){
         if(snapshot.hasError)
           return Center(child: Text("${snapshot.error}"));
           switch (snapshot.connectionState){
             case ConnectionState.waiting: return Center(child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            backgroundColor: Colors.white,
          ));
             default:
             return GridView.builder(
               shrinkWrap: true,
               itemCount: snapshot.data.documents.length,
               addAutomaticKeepAlives: true,
               itemBuilder: (context, i) {
                 var imgPath ="https://drive.google.com/uc?export=download&id=${snapshot.data.documents[i]['higher']}";
                 var img =snapshot.data.documents[i]['lower'];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: new InkWell(
                onTap: () {
                  Navigator.push(context,
                    PageRouteBuilder(
                       barrierColor: Colors.white,
                       transitionDuration: Duration(milliseconds: 500),
                       pageBuilder: (context, animation, secondaryAnimation) {
                         return FullScreen(imgPath,img);
                       },
                    )
                  );
                  print("$i  "+img);
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: new FadeInImage(
                      image: new AdvancedNetworkImage(
                        img,
                        useDiskCache:true,
                        cacheRule:CacheRule(maxAge: const Duration(days:7)),
                        ),
                      fit: BoxFit.cover,
                      placeholder: AssetImage("Assets/Images/loading.gif")
                    ),
                ),
            ),
              );
                },
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: (width/2.5)/ 300
                 )
             );
           }
       }
     )
     );

  }
}