import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoplight/models/api.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:http/http.dart' as http;
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/pages/product_details.dart';
import 'package:shoplight/services/product_service.dart';


class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  ProductService _productService = ProductService();

List<ProductModel> _productList = [];

 _getAllHotProducts() async {
   var hotProducts = await _productService.getHotProducts();
   var result = json.decode(hotProducts.body);
   setState(() {
        _productList = result.map<ProductModel>((item) => ProductModel.fromJson(item)).toList();
   });
   print(_productList);
 }
@override
 void initState() {
    // TODO: implement initState
    super.initState();
   _getAllHotProducts();
  }
  
  @override
Widget build(BuildContext context) {


   return GridView.builder(
     itemCount: _productList.length,
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2), 
       itemBuilder: ( context, i){ 
         final x= _productList[i];
         return Card(
        child: Material(
          child: InkWell(
            onTap: () => 
            Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (context) => new ProductDetails(
                
                product_detail_name: x.product_title,
                product_detail_new_price: x.product_price,
                product_detail_old_price: x.product_sale,
                // product_desct: x.product_desc,
                product_detail_picture: 'https://www.sh-oplight.com/admin_area/product_images/'+x.product_img1,
                productmodel: x,
                

              ))),
          child: GridTile(
            footer: Container(
              color: Colors.white38,
              
              height: 50.0,

              child: ListTile(
                
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 1,right: 8,bottom: 0),
                  child: Text(x.product_title,
                  textDirection: TextDirection.rtl,
                   style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: 7.0),
                   ),

                   
                ),
                
// title:Padding(
//                   padding: const EdgeInsets.only(top: 5.0,),
//                   child: Row(children: <Widget>[
//                      Text(x.product_price,
//                     textDirection: TextDirection.rtl,
//                     style: TextStyle(
//                       color: Color(0xfff8d008),
//                        fontWeight: FontWeight.w800,fontSize: 10.0),
//                        ),
//                   ],),
//                 )
                
                  
                  //    subtitle: Text(x.product_sale,
                  // style: TextStyle(
                  //   color: Colors.red,
                  //    fontWeight: FontWeight.w800,
                  //    decoration: TextDecoration.lineThrough),
                  //    ),
              ),
              
            ),
            child: Container(
              padding: EdgeInsets.all(50),
              height: 50,
              width: 50,
              child:Image.network(
              'https://www.sh-oplight.com/admin_area/product_images/'+x.product_img1,
              fit: BoxFit.cover,             
            ),
            ),
            ),
          ),
          ),
    );
       },
   );

}

}
