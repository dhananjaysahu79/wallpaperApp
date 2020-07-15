import 'dart:typed_data';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
class FullImage extends StatefulWidget {
  var imgPath,img,tag;

  FullImage(this.imgPath,this.img,this.tag);

  @override
  _FullImageState createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {


  static final MobileAdTargetingInfo targetInfo =new  MobileAdTargetingInfo(
    keywords: <String>["wallpapers","amoled","deskpixel"],
  );

  InterstitialAd interstitialAd;
  InterstitialAd createInterstitialAd(){
    return InterstitialAd(
      adUnitId: "ca-app-pub-3957166776873231/1063121570",
      targetingInfo: targetInfo,
    );
  }
  @override
  void initState() {
    super.initState();
     FirebaseAdMob.instance.initialize(appId: "ca-app-pub-3957166776873231~3090519114");
  }
   @override
  void dispose() {
    interstitialAd?.dispose();
    super.dispose();
  }

  static const platform = const MethodChannel("com.flutter.epic/epic");
   bool isPressed=false;
  var progress="";
  var _setWallpaper="";
  var setwallbar=false;
  _save()async{
    createInterstitialAd()..load()..show();
    var status =await Permission.storage.request();
    if (status.isGranted){
      var response = await Dio().get(widget.imgPath,options:Options(responseType:ResponseType.bytes));
      final result= await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      print(result);
      return result;
    }
    else if(status.isDenied){
      throw("You need to give storage permission");
    }
    else if(status.isRestricted){
      openAppSettings();
    }

  }
  Future _download(var value)async{
    createInterstitialAd()..load()..show();
    Dio dio = new Dio();
    try{
      var dir = await getTemporaryDirectory();
      await dio.download(widget.imgPath,"${dir.path}/deskpixel.jpeg",
      onReceiveProgress:(rec,total){
        setState((){
          progress = ((rec/total)*100).toStringAsFixed(0)+"%";
          print(progress);
          if(progress == "100%"){
            _setWall(value);
          }
        });
      });
    }catch(_){
      print(_);
    }
  setState((){
    progress = "Done!";
  });
  }


  Future _setWall(var value)async{
    String setWallpaper;
    try{
      var result = await platform.invokeMethod("setWall","deskpixel.jpeg $value");
      print(result);
      setWallpaper = "Wallpaper Updated Successfully";
    } on PlatformException catch(_){
      setWallpaper = "Failed to Set Wallpaper";
    }
    setState(() {
      _setWallpaper = setWallpaper;
    });
  }



  Future <void> _showDialog(context){
    return showDialog<void>(
    context:context,
    builder:(BuildContext){
      return AlertDialog(
        title: new Text("Success",style: TextStyle(color:Colors.black),),
        content: new Text("Image Saved to Gallery"),
        actions: <Widget>[
          new FlatButton(
            child: new Text("OK"),
            onPressed: (){
              Navigator.of(context).pop();
              },
          )
        ],
      );
    }
 );
}


var progs=0;





  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

  return Scaffold(
      body: Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        InkWell(
           onTap: (){
               setState(() {
                 isPressed=!isPressed;
                 setwallbar=false;
               });
             },
           child: Container(
           height: double.infinity,
           width:double.infinity,
           color: Colors.white,
           child:PhotoView(
            backgroundDecoration: BoxDecoration(
              color: Color.fromARGB(255, 16, 39, 51),
            ),
            tightMode: true,
            // loadFailedChild: Container(
            //   decoration: BoxDecoration(
            // image: DecorationImage(
            //   fit: BoxFit.cover,
            //   image: NetworkImage(widget.img))
            //   ),
            //   ),
            heroAttributes: PhotoViewHeroAttributes(tag: widget.tag,placeholderBuilder: (context, heroSize, child) {
              return Container(
                 height: double.infinity,
                 width: double.infinity,
                 color:Color.fromARGB(255, 16, 39, 51),
              );
            },),

             initialScale: PhotoViewComputedScale.covered,
             minScale: PhotoViewComputedScale.covered,
             maxScale: PhotoViewComputedScale.contained,
            imageProvider: new AdvancedNetworkImage(
            widget.imgPath,
             useDiskCache:true,
             loadingProgress: (progress, data) {
              setState(() {
                progs=(progress*100).toInt();
              });
             },
             cacheRule: CacheRule(maxAge: const Duration(days:7))
             ),
           ),
          ),
        ),
        progs>98||progs==0?Container():Padding(
          padding: const EdgeInsets.only(left:12.0,top:35),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.black,child: Text("$progs",style: TextStyle(color: Colors.white,fontSize: 12),)),
        ),
        Center(
          child: progress==""?Container():Card(
            elevation: 20,
               color: Colors.white,
              child: Container(
              width: 250,
              height: 150,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(progress.toUpperCase(),style: TextStyle(color:Colors.black,fontSize:16,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(_setWallpaper,style: TextStyle(color:Colors.black,fontSize:15),),
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     InkWell(
                       onTap: (){
                         setState(() {
                           progress="";
                         });
                       },
                         child: Card(child: Padding(
                         padding: const EdgeInsets.only(left:18.0,right: 18,top: 8,bottom: 8),
                         child: Text("OK",style: TextStyle(color:Colors.white),),
                       )),
                     )
                  ],)
                ],
              ),
            ),
          ),
        )
      ],
    ),
     bottomSheet:isPressed==false?Container(
      width: double.infinity,
      height: 60,
      color: Color.fromARGB(255, 16, 39, 51),
      child: isPressed?Container():Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
         IconButton(icon: Icon(Icons.file_download,color: Colors.white,size: 26,),  onPressed:(){
          _save();
          _showDialog(context);
        },),
        FilterChip(
          label: Text("Set Wallpaper") ,onSelected: (bool value) {
            setState(() {
              isPressed=true;
              setwallbar=true;
            });
          },
          backgroundColor: Colors.white,
          avatar: Icon(Icons.color_lens),
        ),
        IconButton(icon: Icon(Icons.cancel,color: Colors.white,size: 26,),  onPressed:(){
          setState(() {
            isPressed=!isPressed;
          });
          Navigator.of(context).pop();},)
      ],)
     ):Container(
       color: Color.fromARGB(255, 16, 39, 51),
       height: setwallbar?60:1,
       width: double.infinity,
       child: setwallbar?Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[
          InkWell(
          onTap: (){
             _download("home");
          },
            child: Container(
            height: 35,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width/3.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Text("HOMESCREEN",style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
          ),
        ),
        InkWell(
          onTap: (){
            _download("lock");
          },
            child: Container(
            height: 35,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width/3.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Text("LOCKSCREEN",style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
          ),
        ),
        InkWell(
          onTap: (){
           _download("both");
          },
            child: Container(
            height: 35,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width/3.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Text("BOTH",style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
          ),
        )
       ],):Container(),
     )
  );
  }
}