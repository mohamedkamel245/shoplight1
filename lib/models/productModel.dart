class ProductModel {
  dynamic product_id;
  String product_title;
  dynamic product_price;
  dynamic product_sale;
  String product_img1;
  String product_desc;
  String product_label;
  dynamic product_quantity;


  ProductModel(
      {this.product_id,
      this.product_title,
      this.product_price,
      this.product_sale,
      this.product_img1,
      this.product_desc,
      this.product_label,
      this.product_quantity,
      });

      // void incrementQuantity(){
      //   this.productQuantity = this.productQuantity + 1;

      // }

      // void decrementQuantity(){
      //   this.productQuantity = this.productQuantity - 1;
      // }
        toMap(){
    var map = Map<String, dynamic>();
    map['product_id'] = product_id;
    map['product_title'] = product_title;
    map['product_price'] = product_price;
    map['product_sale'] = product_sale;
    map['product_img1'] = product_img1;
    map['product_quantity'] = product_quantity;
    return map;
  }

  fromMap(){
    
  }

 factory ProductModel.fromJson(Map<String, dynamic> json) {
   return ProductModel(product_id: json['product_id']  as String,
   product_title: json['product_title'] as String,
    product_price: json['product_price'] as String ,
    product_sale: json['product_sale'] as String,
    product_img1 : json['product_img1'] as String,
    product_desc : json['product_desc'] as String,
    product_label : json['product_label'] as String,
    product_quantity : json['product_quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['product_title'] = this.product_title;
    data['product_price'] = this.product_price;
    data['product_sale'] = this.product_sale;
    data['product_img1'] = this.product_img1;
    data['product_desc'] = this.product_desc;
    data['product_label'] = this.product_label;
    data['product_quantity'] = this.product_quantity;
    return data;
  }
}


