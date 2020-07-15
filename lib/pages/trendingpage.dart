import 'package:deskpixel/pages/fullimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'dart:math';


class TrendingPage extends StatelessWidget {
  var darktheme;
  TrendingPage(this.darktheme);
  @override

  List apikeys=["Your Pexel Api keys goes here..."];

  Future getWallPaper()async{
    List<ApiData> data =[];
  var url="https://api.pexels.com/v1/curated?per_page=400&page=1";
  //final random = new Random();
   var apikey =apikeys[Random().nextInt(apikeys.length)];
   await http.get(url,
   headers:{
      "Authorization" : apikey
   }).then((value){
   var decodedJson = jsonDecode(value.body);
   ApiData apiData;
   decodedJson["photos"].forEach((element){
     apiData=ApiData(element["src"]["portrait"]);
     data.add(apiData);
     print(data[0].link);
   });
   });

   return data;
  }


  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
     var width=MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent,),
        child: Scaffold(
         appBar: AppBar(
          title:Text("Trending",
         textScaleFactor: 0.8,
         style:TextStyle(color:darktheme?Colors.white:Colors.black)
            ),
            brightness: darktheme?Brightness.dark:Brightness.light,
            iconTheme: IconThemeData(
              color:darktheme?Colors.white:Colors.black
            ),
          ),
        body: FutureBuilder(
        future: getWallPaper(),
        builder:  (BuildContext context, AsyncSnapshot snapshot){
          return (snapshot.data==null)?Center(child: CircularProgressIndicator()):
          GridView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, i) {
            String imgPath = snapshot.data[i].link;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: new InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return FullImage(imgPath,imgPath, "desk$i");
                  }));
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
                ),
              ),
            ); },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (width/2.5)/ 300
          )
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