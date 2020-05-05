import 'package:flutter/material.dart';
import 'package:shoplight/models/categories.dart';

import 'home_product_category.dart';


class HomePeoductCategories extends StatefulWidget {
  final List<Categories> categoriesList;
  HomePeoductCategories({this.categoriesList});
  @override
  _HomePeoductCategoriesState createState() => _HomePeoductCategoriesState();
}

class _HomePeoductCategoriesState extends State<HomePeoductCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.widget.categoriesList.length,
        itemBuilder: (context, i){
          return HomeProductCategory(this.widget.categoriesList[i].api_cat_image,this.widget.categoriesList[i].p_cat_title);
        },
      ) ,
    );
  }
}