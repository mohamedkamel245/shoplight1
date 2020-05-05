import 'dart:convert';

import 'package:shoplight/models/productModel.dart';

class Shipping{
 int id;
  String name;
  String username;
  String city;
  String region;
  String streetnumber;
  String buildingnumber;
  String titletype;
  String mobilenumber;
  int userId;
  List<ProductModel> cartItems;

Shipping({
this.id,
this.name,
this.username,
this.city,
this.region,
this.streetnumber,
this.buildingnumber,
this.titletype,
this.mobilenumber,
this.userId,
this.cartItems,
});
  toJson(){
    return {
      'id' : id.toString(),
      'userId' : userId.toString(),
      'name' : name,
      'username' : username,
      'city' : city,
      'region' : region,
      'streetnumber' : streetnumber,
      'buildingnumber' : buildingnumber,
      'titletype' : titletype,
      'mobilenumber' : mobilenumber,
      'cartItems' : json.encoder.convert(cartItems),
    };
  }
}