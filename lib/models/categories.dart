import 'package:shoplight/models/productModel.dart';

class Categories {
  String p_cat_id;
  String p_cat_title;
  String api_cat_image;
  List<ProductModel> products;


  Categories(
      {this.p_cat_id,
      this.p_cat_title,
      this.api_cat_image,
      this.products,
      
      });

 factory Categories.fromJson(Map<String, dynamic> json) {
   var list = json['products'] as List;
   List<ProductModel> productList = list.map((i)=>ProductModel.fromJson(i)).toList();
  
   return Categories(
     products: productList,
    p_cat_id: json['p_cat_id'],
    p_cat_title: json['p_cat_title'],
    api_cat_image: json['api_cat_image'],


   );
    
  }
}


