import 'package:flutter/material.dart';
import 'package:shoplight/Dormitories/Hour_s.dart';
import 'package:shoplight/pages/product_details.dart';
import 'package:shoplight/pages/signup_page.dart';
import 'package:shoplight/services/products_bycategory_screen.dart';

class HomeProductCategory extends StatefulWidget {
  
  final String categoryImage;
  final String categoryTitle;
  HomeProductCategory(this.categoryImage,this.categoryTitle,);
  @override
  _HomeProductCategoryState createState() => _HomeProductCategoryState();
}

class _HomeProductCategoryState extends State<HomeProductCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 190.0,
      
      child: InkWell(
        onTap: (){
          Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Hours()));
        },
              child: Card(
          color: Color(0xfff8d008),
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  'https://www.sh-oplight.com/admin_area/api_images/'+widget.categoryImage,
                  width: 50.0,
                  height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(widget.categoryTitle,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w900,color: Colors.black),
                   textDirection: TextDirection.rtl,
                    ),
                    ),
              ],),
          ),
        ),
      ),
    );
  }
}