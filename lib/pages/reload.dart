import 'package:deskpixel/pages/searchedpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Reload extends StatelessWidget {
  var text,darktheme;
  Reload(this.text,this.darktheme);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
       Stack(
         alignment: Alignment.center,
         children: <Widget>[
          Container(
          height: MediaQuery.of(context).size.height/3,
          decoration: BoxDecoration(
           color:Color.fromARGB(255, 38, 43, 65),
            shape: BoxShape.circle,
          ),
        ),
          Container(
          height: 150,
          width: 150,
            child: SvgPicture.asset("Assets/Images/Astronaut.svg")
            ),
         ],
       ),
       SizedBox(height:  MediaQuery.of(context).size.height/20,),
        Text("No Connection",
         textScaleFactor: 0.8,
         style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),

        ),
        SizedBox(height:  MediaQuery.of(context).size.height/20,),
         Text("You are 404 million kilometers away from us.",
         textScaleFactor: 0.8,
         style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
        ),
        Text("Please tap on refresh button to try connecting back.",
         textScaleFactor: 0.8,
         style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
        ),
        SizedBox(height:  MediaQuery.of(context).size.height/20,),
        Container(
          width: MediaQuery.of(context).size.width/1.2,
          height: 40,
          child: RaisedButton(
            color: Color(0xFF6C63FF),
            child:  Text("REFRESH NOW",
                textScaleFactor: 0.8,
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
               ),
            onPressed:(){
           Navigator.of(context).pushReplacement(
             MaterialPageRoute<Null>(
             builder:(BuildContext context){
             return SearchedPage(text,darktheme);
            }));

            }
            ),
        )
      ],
    );
  }
}