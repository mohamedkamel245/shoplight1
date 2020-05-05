import 'package:flutter/material.dart';

class ProductDelailss extends StatefulWidget {
 final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;


ProductDelailss({
this.product_detail_name,
this.product_detail_new_price,
this.product_detail_old_price,
 this.product_detail_picture,

});


  @override
  _ProductDelailssState createState() => _ProductDelailssState();
}

class _ProductDelailssState extends State<ProductDelailss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.product_detail_name),
      ),
    );
  }
}