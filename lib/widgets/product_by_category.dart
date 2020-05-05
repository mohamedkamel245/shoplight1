import 'package:flutter/material.dart';
import 'package:shoplight/models/productModel.dart';

class ProductByCategory extends StatefulWidget {
  final ProductModel productModel;
  ProductByCategory(this.productModel);
  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 190,
      child: Card(
        child: Column(children: <Widget>[
          Text(this.widget.productModel.product_title),
          Image.network(widget.productModel.product_img1, width: 190.0, height: 160.0),
          Row(
            children: <Widget>[
              Text('السعر: ${this.widget.productModel.product_price}'),
              Text('التخفيض: ${this.widget.productModel.product_sale}'),
            ],
          ),
        ],),
      ),
    );
  }
}