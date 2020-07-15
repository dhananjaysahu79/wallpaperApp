import 'dart:io';
import 'package:deskpixel/pages/fullimage.dart';
import 'package:deskpixel/pages/reload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'dart:math';

class SearchedPage extends StatefulWidget {
  var text ,darktheme;
  SearchedPage(this.text,this.darktheme);

  @override
  _SearchedPageState createState() => _SearchedPageState();
}

class _SearchedPageState extends State<SearchedPage> {

  List apikeys=["Your Pexel Api keys goes here..."];
  List<ApiData> data =[];
  List pageIndex= ["1","3","5","7","9"];
  Future getWallPaper()async{

  var url="https://api.pexels.com/v1/search?query=${widget.text}&per_page=400&page=${pageIndex[Random().nextInt(pageIndex.length)]}";
  try{
  var apikey =apikeys[Random().nextInt(apikeys.length)];
   await http.get(url,
   headers:{
      "Authorization" : apikey
    }).timeout(const Duration(seconds: 5)).then((value){

   var decodedJson = jsonDecode(value.body);
   ApiData apiData;
   decodedJson["photos"].forEach((element){
     apiData=ApiData(element["src"]["portrait"]);
     data.add(apiData);
   });
   });
  } on TimeoutException catch(_){
     return "error";
  } on SocketException catch(_){
     return "error";
  }
    return data;
  }



  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
     var width=MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent,),
        child: Scaffold(
         appBar: AppBar(
      title:Text(widget.text,
         textScaleFactor: 0.8,
         style:TextStyle(color:widget.darktheme?Colors.white:Colors.black)
      ),
      brightness: widget.darktheme?Brightness.dark:Brightness.light,
      iconTheme: IconThemeData(
        color:widget.darktheme?Colors.white:Colors.black
      ),
    ),
        body: FutureBuilder(
        future: getWallPaper(),
        builder:  (BuildContext context, AsyncSnapshot snapshot){
          return (snapshot.data==null)?Center(child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            backgroundColor: Colors.white,
          )):
          snapshot.data=="error"?Reload(widget.text,widget.darktheme):StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: snapshot.data.length,
          itemBuilder: (context, i) {
            String imgPath = snapshot.data[i].link;
            return new InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return FullImage(imgPath,imgPath, "desk$i");
                }));
              },
              child: new Hero(
                tag:  "desk$i",
                child: new FadeInImage(
                  image: new AdvancedNetworkImage(
                    imgPath,
                    useDiskCache:true,
                    cacheRule:CacheRule(maxAge: const Duration(days:7)),
                    ),
                  fit: BoxFit.cover,
                  placeholder: AssetImage("Assets/Images/loading.gif")
                ),
              ),
            );
          },
          staggeredTileBuilder: (i) =>
          new StaggeredTile.count(2, i.isEven ? 2 : 3),
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        );
        }
        ),
        )
    );
  }
}

class ApiData{
  final String link;
  ApiData(this.link);
}