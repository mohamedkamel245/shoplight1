import 'dart:convert';
import 'dart:ffi';
import 'dart:ui' as prefix0;
import 'package:flutter/material.dart';
import 'package:shoplight/componets/cart_products.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/services/cart_service.dart';
import 'package:shoplight/services/product_service.dart';



class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;
  final  productmodel;


ProductDetails({
this.product_detail_name,
this.product_detail_new_price,
this.product_detail_old_price,
 this.product_detail_picture,
 this.productmodel,

});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 ProductService _productService = ProductService();

 CartService _cartService = CartService();

 List<ProductModel> _cartItems;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  _getAllsliders();
    _getCartItems();
   
    
  }

 _getCartItems() async{
   _cartItems = List<ProductModel>();
   var cartItems = await _cartService.getCartItems();
   cartItems.forEach((data){
     var productmodel = ProductModel();
     productmodel.product_id = data['product_id'];
     productmodel.product_title = data['product_title'];
     productmodel.product_img1 = data['product_img1'];
     productmodel.product_price = data['product_price'];
     productmodel.product_sale = data['product_sale'];
     productmodel.product_desc = data['product_desc'] ?? 'No desc';
     productmodel.product_quantity = data['product_quantity'];
     setState(() {
       _cartItems.add(productmodel);
       
     });
   });

 }

 _addToCart(BuildContext context, ProductModel productmodel) async{
   var result = await _cartService.addToCart(productmodel);
  
   if (result > 0) {
      _getCartItems();
     _showSnackMessage(
      
       Text("تم الإضافة الي سلة العربة",
     textDirection: TextDirection.rtl,
     style: TextStyle(color: Color(0xfff8d008),fontSize: 15.0,fontWeight: FontWeight.bold),
     
     ),
     );
     
   } else {
     
     _showSnackMessage(Text("تعذرت الاضافة الي سلة العربة"));
   }
 }

 _showSnackMessage(message){
    var snackBar = SnackBar(
      content: message,
    );
    
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Row(
          
          children: <Widget>[
           
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Image.asset('images/cats/Untitled-trr1.png'),
            ),
           Text('متجر ضوء', style: TextStyle(color: Color(0xfff8d008))),
              
        ],
        
        ),
        
          
          centerTitle: true,
         actions: <Widget>[
          // new IconButton(icon: Icon(Icons.search,color: Color(0xfff8d008),),onPressed: (){}),
          
        InkWell(
          onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart_products(_cartItems)));

          },
                  child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                           child: Center(child: Text(_cartItems.length.toString()),
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
      body: new ListView(
        
        children: <Widget>[
          new Container(
            height: 200.0,
         
            child: GridTile(
              
              child: Container(
                
                color: Colors.white,
                child: Image.network(widget.product_detail_picture),
              ),
              footer: new Container(
                color: Colors.black,
                child: ListTile(
                  
                  trailing: new Text(widget.product_detail_name,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0,color: Color(0xfff8d008)),),
                  
                   title: new Row(
                     children: <Widget>[
                       
                         
                         Expanded(
                         child: new Text("${widget.product_detail_new_price}ريال",
                         textDirection: TextDirection.rtl,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xfff8d008),fontSize: 12.0,
                         ),
                         )
                         ),
                         
                         Expanded(
                         child: new Text("${widget.product_detail_old_price}ريال",
                         textDirection: TextDirection.rtl,
                         style: TextStyle(color: Colors.red, decoration: TextDecoration.lineThrough,fontSize: 12.0),
                         )
                       ),
                     ],
                   ),
                ),
              ),
              
              ),
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                  showDialog(context: context,
                  builder: (context){
                    return new AlertDialog(
                      title: new Text(""),
                      content: new Text(" "),
                      actions: <Widget>[
                        new MaterialButton(onPressed: (){
                          Navigator.of(context).pop(context);
                        },
                        child: new Text(""),
                        ),
                      ],
                    );
                  },
                  );
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Text("")
                      ),
                      Expanded(
                        child: new Icon(
                          Icons.arrow_drop_down))
                  ],
                ),
                )
                ),

                Expanded(
                child: MaterialButton(onPressed: (){
                  showDialog(context: context,
                  builder: (context){
                    return new AlertDialog(
                      title: new Text(""),
                      content: new Text(""),
                      actions: <Widget>[
                        new MaterialButton(onPressed: (){
                          Navigator.of(context).pop(context);
                        },
                        child: new Text(""),
                        ),
                      ],
                    );
                  },
                  );
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Text("")
                      ),
                      Expanded(
                        child: new Icon(
                          Icons.arrow_drop_down))
                  ],
                ),
                )
                ),


            ],
          ),

           Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: (){
                    
                  _addToCart(context, widget.productmodel);
                  
                },
                color: Color(0xfff8d008),
                textColor: Colors.black,
                child: new Text("اشتري الأن",
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0),
                )
                ),
                ),
               new IconButton(icon: Icon(Icons.add_shopping_cart, color: Color(0xfff8d008)), onPressed: (){}),
               new IconButton(icon: Icon(Icons.favorite_border, color: Color(0xfff8d008)), onPressed: (){}),
            ],
          ),
            Divider(),
            new ListTile(
              
              trailing: new Text("تفاصيل المنتج"),
              subtitle: new Text("إضافة جديدة لعشاق مسك الجسم وأصنافه.",
              textDirection: TextDirection.rtl,
              ),
            ),
            Divider(),
            new Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(0),
                child:Align(
                  alignment: Alignment.center,
                child: new Text(widget.product_detail_name,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.w600),),
                ),
                ),
                Padding(padding: const EdgeInsets.all(0),
               
                  
                child: new Text("اسم المنتج : ",textDirection: TextDirection.rtl, style: TextStyle(color: Colors.grey),
                 ),
                
                ),
                

              ],
            
            ),

            new Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 180.0),
                child: new Text("1م100"),
                ),
                Padding(padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                child: new Text(":العلامة التجارية المنتج", style: TextStyle(color: Colors.grey),
                 ),
                ),
                
              ],
            
            ),
            
            new Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 245.0),
                child: new Text("جديد"),
                ),

                Padding(padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                child: new Text(":حالة المنتج", style: TextStyle(color: Colors.grey),
                 ),
                
                ),
                
              ],
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:Align(
                  alignment: Alignment.center,
              child: new Text("منتجات مماثلة"),
              ),
            ),
            Container(
              height: 340.0,
              // child: Similar_products(),
            ),

        ],
      ),
    );
  }
}

// class Similar_products extends StatefulWidget {
//   @override
//   _Similar_productsState createState() => _Similar_productsState();
// }

// class _Similar_productsState extends State<Similar_products> {
//   var product_list = [
//     {
//       "name": "L,amour",
//       "picture": "images/products/a2.jpg",
//       "old_price":120,
//       "price": 85,
//     },
//     {
//       "name": "L,amour",
//       "picture": "images/products/a3.jpg",
//       "old_price":120,
//       "price": 85,
//     },
//     {
//       "name": "a,amour",
//       "picture": "images/products/a5.jpg",
//       "old_price":20,
//       "price": 5,
//     },
//     {
//       "name": " m,amour",
//       "picture": "images/products/a6.jpg",
//       "old_price":12,
//       "price": 8,
//     },
    
//   ];
//   @override
//   Widget build(BuildContext context) {
//    return GridView.builder(
//      itemCount: product_list.length,
//      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//        crossAxisCount: 2), 
//        itemBuilder: (BuildContext context, int index){
//          return Similar_single_prod(
//            prod_name: product_list[index]['name'],
//            prod_pricture: product_list[index]['picture'],
//            prod_old_price: product_list[index]['old_price'],
//            prod_price: product_list[index]['price'],
//          );
//        });
// }
// }

// class Similar_single_prod extends StatelessWidget {
//   final prod_name;
//   final prod_pricture;
//   final prod_old_price;
//   final prod_price;

//   Similar_single_prod({
//     this.prod_name,
//     this.prod_pricture,
//     this.prod_old_price,
//     this.prod_price,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         child: Material(
//           child: InkWell(
//             onTap: () => 
//             Navigator.of(context).push(
//             new MaterialPageRoute(
//               builder: (context) => new ProductDetails(
//                 product_detail_name: prod_name,
//                 product_detail_new_price: prod_price,
//                 product_detail_old_price: prod_old_price,
//                 product_detail_picture: prod_pricture,
//               ))),
//           child: GridTile(
//             footer: Container(
//               color: Colors.white70,
//               child: ListTile(
//                 leading: Text(prod_name,
//                  style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                   title: Text("\$$prod_price",
//                   style: TextStyle(
//                     color: Colors.red,
//                      fontWeight: FontWeight.w800),
//                      ),
//                      subtitle: Text("\$$prod_old_price",
//                   style: TextStyle(
//                     color: Colors.amber,
//                      fontWeight: FontWeight.w800,
//                      decoration: TextDecoration.lineThrough),
//                      ),
//               ),
//             ),
//             child: Image.asset(
//               prod_pricture,
//               fit: BoxFit.cover,
//             ),
//             ),
//           ),
//           ),
          
//     );
//   }
// }