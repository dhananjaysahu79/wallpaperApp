import 'package:flutter/material.dart';
import 'package:deskpixel/pages/searchedpage.dart';
class CategoryTile extends StatelessWidget {
   var index,darktheme;
   CategoryTile(this.index,this.darktheme);

  @override
   List type=[
      "Nature","HD","Street","Buildings","Tech","Fitness","Dark","Blue"
   ];

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
        onTap:()=>{Navigator.of(context).push(MaterialPageRoute<Null>(builder:(BuildContext context){return SearchedPage(type[index],darktheme);}))},
          child:  Container(
            decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(10),
            color: Color.fromARGB(255, 40, 63, 77)
            ),
              height:height/20,
              width: width/5,
              child: Center(
              child: new Text(type[index],
              textScaleFactor: 0.8,
              style: TextStyle(
                fontFamily: "GoogleSans",
                fontSize:17,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),)),
          ),
      );

  }
}