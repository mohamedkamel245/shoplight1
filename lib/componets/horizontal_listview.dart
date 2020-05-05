import 'package:flutter/material.dart';

import 'package:shoplight/Dormitories/Hour_s.dart';
import 'package:shoplight/Dormitories/Perfume_s.dart';
import 'package:shoplight/Dormitories/bag_s.dart';

class HorizontalList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
                  InkWell(
                        onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => new Hours()),);
           },
                    child: Category(
           image_location: 'images/cats/b5.png',
           image_caption: 'ساعات',
         ),
                  ),
            
         InkWell(
           onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => new Bags()),);
           },
           child: Category(
             image_location: 'images/cats/b3.png',
             image_caption: 'حقائب',
           ),
         ),

         InkWell(
           onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => new Perfumes()),);
           },
           child: Category(
             image_location: 'images/cats/b4.png',
             image_caption:  'التجميل',
           ),
         ),


         InkWell(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => new Perfumes()),);
           },
           child: Category(
             image_location: 'images/cats/b1.png',
             image_caption: 'عطور',
           ),
         ),
         

        ],
      ) ,
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({
    this.image_location,
    this.image_caption
  }
  );
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left: 0,right: 5,top: 5,bottom: 20,),
      child: InkWell(onTap: (){},
      child: Container(
        width: 90.0,
              child: ListTile(
          title: Image.asset(image_location,
          width: 100.0,
          height: 150.0,
          ),
          subtitle: Container(
            alignment: Alignment.topCenter,
            child: Text(image_caption, style: TextStyle(color: Colors.black, fontSize: 12.0),),
          )
        ),
      ),
      ),
    );
  }
}