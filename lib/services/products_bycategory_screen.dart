import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoplight/models/product.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/services/product_service.dart';
import 'package:shoplight/widgets/product_by_category.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String categoryTitle;
  final int catId;

  ProductsByCategoryScreen({this.categoryTitle,this.catId});
  @override
  _ProductsByCategoryScreenState createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  ProductService _productService = ProductService();

  List<ProductModel> _productsByCategoryScreen = List<ProductModel>();

  _getProductsByCategory() async {
   var products = await _productService.getProductsByCategoryId(this.widget.catId);
    var _list = json.decode(products.body);
    setState(() {
        _productsByCategoryScreen = _list.map<ProductModel>((item) => ProductModel.fromJson(item)).toList();
   });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.categoryTitle),

      ),
      body: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
         itemCount: _productsByCategoryScreen.length,
         itemBuilder: (context, index){
           return ProductByCategory(this._productsByCategoryScreen[index]);
         },
         ),
      ),
    );
  }
}