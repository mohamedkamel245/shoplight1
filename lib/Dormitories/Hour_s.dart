import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoplight/models/categories.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/models/sliderModel.dart';
import 'package:shoplight/pages/product_details.dart';
import 'package:shoplight/services/category_service.dart';
import 'package:shoplight/services/product_service.dart';
import 'package:shoplight/widgets/slider2_service.dart';

class Hours extends StatefulWidget {
  @override
  _HoursState createState() => _HoursState();
}

class _HoursState extends State<Hours> {
  ProductService _productService = ProductService();
 CategoryService _categoryService = CategoryService();
var loadling = false;
List<ProductModel> _productList = [];

List<Categories> listCategory = [];
 List<SliderModel> list = [
 SliderModel(slide_id:"1" ,slide_image: "https://www.sh-oplight.com/admin_area/slides_images/Post%207%20slider%20(1).jpg"),
  //  SliderModel(slide_id:"2" ,slide_image: "https://images.pexels.com/photos/326502/pexels-photo-326502.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
  
 ];

 _getAllHotProducts() async {
   var hotProducts = await _productService.getHotProducts();
   var result = json.decode(hotProducts.body);
   setState(() {
        _productList = result.map<ProductModel>((item) => ProductModel.fromJson(item)).toList();
   });
   print(_productList.length);
 }




_caid()async{
  setState(() {
  loadling = true;
});
  final categories = await _categoryService.getCategory();
  if (categories.statusCode ==200) {
    final data = jsonDecode(categories.body);
    print(data);
    setState(() {
      for(Map i in data){
        listCategory.add(Categories.fromJson(i));
      }
      loadling = false;
    });
  } else {
    setState(() {
      loadling = false;
    });
  }
}

Future<void> onRefresh() async {
  _caid();
  setState(() {
    flutter = false;
  });
}

int index = 0;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _caid();
   _getAllHotProducts();
    
  }




var flutter = false;

//  _getAllHotProducts() async {
//    var hotProducts = await _productService.getHotProducts();
//    var result = json.decode(hotProducts.body);
//    setState(() {
//         _productList = result.map<ProductModel>((item) => ProductModel.fromJson(item)).toList();
//    });
//    print(_productList.length);
//  }
// @override
//  void initState() {
//     // TODO: implement initState
//     super.initState();
//    _getAllHotProducts();
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Row(
          
          children: <Widget>[
           
            Image.asset('images/cats/Untitled-trr.png'),
           Text('متجر ضوء', style: TextStyle(color: Color(0xfff8d008))),
              
        ],
        
        ),
        
          
          centerTitle: true,
         actions: <Widget>[
          // new IconButton(icon: Icon(Icons.search,color: Color(0xfff8d008),),onPressed: (){}),
          
        InkWell(
          onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart_products(_cartItems)));

          },
                  child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              width: 30,
               child: Stack(
                 children: <Widget>[
                   IconButton(
                     iconSize: 25,
                     icon: Icon(Icons.shopping_cart, color: Color(0xfff8d008),), onPressed: (){
                       
                     }),
                     Positioned(
                       child: Stack(
                       children: <Widget>[
                         Icon(Icons.brightness_1, size: 20, color: Colors.red),
                         Positioned(
                           top: 1.0,
                           left: 5.0,
                           child: Center(child: Text(''),
                           )
                           ),
                       ],
                     ),
                     ),
                 ],
               ),
            ),
            
          ),
        )
          
        ],
      ),
    

      body:  loadling ? Center(
        
child: CircularProgressIndicator(),
   ): RefreshIndicator(
     onRefresh: onRefresh,
     
     child: ListView(
       
       children: <Widget>[
         
         carousel2Slider(list),
         SizedBox(
           height: 1,
         ),
         Container(
           width: 100.0,
           height: 190.0,
           
           child: ListView.builder(
             
             shrinkWrap: true,
             scrollDirection: Axis.horizontal,
             
             itemCount: listCategory.length,
             itemBuilder: (context, i){
               final a = listCategory[i];
               return InkWell(
                 onTap: (){
                   setState(() {
                     flutter = true;
                     index = i;
                     print(flutter);
                   });
                 },
                 child: Card(
                   
                   margin: EdgeInsets.only(right: 1, left: 5,top: 62,bottom: 45),
                   color: Color(0xfff8d008),
          child: Padding(
            padding: const EdgeInsets.all(6),
            
            child: Column(
              
              children: <Widget>[
                Image.network(
                  'https://www.sh-oplight.com/admin_area/api_images/'+a.api_cat_image,
                  width: 50.0,
                  height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(a.p_cat_title,style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.w900,color: Colors.black),
                   textDirection: TextDirection.rtl,
                    ),
                    ),
              ],),
          ),

                 ),
               );
             },
           ),
         ),
         Container(

         ),
         if (flutter) GridView.builder(
           
           shrinkWrap: true,
           physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(10),
            itemCount: listCategory[index].products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            
            ),
            itemBuilder: (context, i){
              final a = listCategory[index].products[i];
              return InkWell(
                onTap: (){

                   Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (context) => new ProductDetails(
                
                product_detail_name: a.product_title,
                product_detail_new_price: a.product_price,
                product_detail_old_price: a.product_sale,
                // product_desct: x.product_desc,
                product_detail_picture: 'https://www.sh-oplight.com/admin_area/product_images/'+a.product_img1,
                productmodel: a,

                ))
                
                   );
                   },
                
                child: Container(
                  
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1, color: Color(0xfff8d008),

                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5, color: Color(0xfff8d008),
                      ),
                    ]
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      
                      Expanded(child: Image.network(
                        'https://www.sh-oplight.com/admin_area/product_images/'+a.product_img1,
                        fit: BoxFit.cover,
                        height: 180,
                      ),
                      
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(a.product_title,
                      textDirection: TextDirection.rtl,),
                    
                      Padding(
                        padding: const EdgeInsets.only(right: 100,),
                        child: Text("${a.product_price}ريال",
                        
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber),
                        ),
                      ),
                    ],

                  ),
                ),
              );
            }
            
           ) else GridView.builder(
           shrinkWrap: true,
           physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(10),
            
            itemCount: _productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            
            ),
            itemBuilder: (context, i){
              final a = _productList[i];
              return InkWell(
                onTap: (){
                    Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (context) => new ProductDetails(
                
                product_detail_name: a.product_title,
                product_detail_new_price: a.product_price,
                product_detail_old_price: a.product_sale,
                // product_desct: x.product_desc,
                product_detail_picture: 'https://www.sh-oplight.com/admin_area/product_images/'+a.product_img1,
                productmodel: a,

                ))
                
                   );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2, color: Color(0xfff8d008),

                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5, color: Color(0xfff8d008),
                      ),
                    ]
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: Image.network(
                        'https://www.sh-oplight.com/admin_area/product_images/'+a.product_img1,
                        fit: BoxFit.cover,
                        height: 180,
                      ),
                      
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(a.product_title,
                      textDirection: TextDirection.rtl,),
                    
                      Padding(
                        padding: const EdgeInsets.only(right: 100,),
                        child: Text("${a.product_price}ريال",
                        
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber),
                        ),
                      ),
                    ],

                  ),
                ),
              );
            },
           ),
       ]
     )
     
     ),
      
    );
  }
}