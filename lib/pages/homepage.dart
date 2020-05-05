import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:shoplight/Dormitories/Hour_s.dart';
import 'package:shoplight/componets/cart_button.dart';
import 'package:shoplight/componets/cart_products.dart';
import 'package:shoplight/componets/horizontal_listview.dart';
import 'package:shoplight/models/api.dart';
import 'package:shoplight/models/categories.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/models/sliderModel.dart';
import 'package:shoplight/pages/cart.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shoplight/services/cart_service.dart';
import 'package:shoplight/services/category_service.dart';
import 'package:shoplight/services/product_service.dart';
import 'package:shoplight/services/slider_service.dart';
import 'package:shoplight/widgets/home_hot_products.dart';
import 'package:shoplight/widgets/home_product_categories.dart';
import 'package:shoplight/widgets/slider_service.dart';

class HomePage extends StatefulWidget {
   final VoidCallback signOut;
  HomePage({this.signOut});

 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SliderService _sliderService = SliderService();
 CategoryService _categoryService = CategoryService();

 ProductService _productService = ProductService();
  CartService _cartService = CartService();
List<ProductModel> _cartItems;
FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


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

 

  List<Categories> _categoriesList = [];
  _getAllCategories() async{
    var categories = await _categoryService.getCategory();
    var result = json.decode(categories.body);
    setState(() {
    _categoriesList = result.map<Categories>((item) => Categories.fromJson(item)).toList();
    });
     print(_categoriesList.length);
  }
 

   
 List<SliderModel> list = [
 SliderModel(slide_id:"1" ,slide_image: "https://www.sh-oplight.com/admin_area/slides_images/Post%207%20slider%20(1).jpg"),
  //  SliderModel(slide_id:"2" ,slide_image: "https://images.pexels.com/photos/326502/pexels-photo-326502.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
  
 ];
_getAllsliders() async {
 // list.clear();
  
  final sliders = await _sliderService.getSliders();
  
  
  final result  = jsonDecode(sliders.body);
    
     setState(() {
       list = result.map<SliderModel>((item) => SliderModel.fromJson(item)).toList();
     });
   print(list);
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  _getAllsliders();
  _getCartItems();
   _getAllCategories();
   _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        
      },
      
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");  
        
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true, alert: true, badge: true
      ),
    );
    
  }
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      endDrawer: new AppDrawer(),
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: <Widget>[

          
        InkWell(
          onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart_products(_cartItems)));

          },
                  child: Padding(
            padding: const EdgeInsets.only(right: 60.0,top: 1.0),
            child: Container(
              height: 30,
              width: 25,
               child: Stack(
                 children: <Widget>[
                   IconButton(
                     iconSize: 30,
                     icon: Icon(Icons.shopping_cart, color: Color(0xfff8d008),), onPressed: (){
                       
                     }),
                     Positioned(
                       child: Stack(
                       children: <Widget>[
                         Icon(Icons.brightness_1, size: 25, color: Colors.red),
                         Positioned(
                           top: 4.0,
                           right: 8.0,
                           
                           child: Center(child: Text(_cartItems.length.toString(),style: TextStyle(fontSize: 15.0),),
                           )
                           ),
                       ],
                     ),
                     ),
                 ],
               ),
            ),
          ),
        ),
            Image.asset('images/cats/Untitled-trr1.png'),
           Text('متجر ضوء', style: TextStyle(color: Color(0xfff8d008))),

                      //  Padding(
                      //    padding: const EdgeInsets.only(left: 40.0),
                      //    child: new IconButton(icon: Icon(Icons.search,color: Color(0xfff8d008),),onPressed: (){}),
                      //  ),
              
        ],
        
        ),
        centerTitle: true,
         actions: <Widget>[
          
          
        ],
      ),
      
    



      body: new ListView(
        children: <Widget>[
           carouselSlider(list),
          new Padding(padding: const EdgeInsets.only(left: 5,top: 4,bottom: 5,),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              color: Color(0xfff8d008),
              child: Text('فئة المنتجات',
          style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.w800),
          ),
            ),
          ),
          ),
          
          
           HomePeoductCategories(categoriesList: _categoriesList),

          new Padding(padding: const EdgeInsets.only(left: 5,top: 40,bottom: 10,),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              color: Color(0xfff8d008),
              child: Text('أفضل االمنتجات لدينا',
          style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.w800),
          ),
            ),
          ),
          ),

          //grid view
          Container(
            
            color: Colors.amber[200],
            
            child: Column(children:<Widget>[
              
              Container(
               
                height: 315,
               child: Products(),
              ),
              
            ]
          ),
          ),
        ],
      ),
    );
  }

}

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
    
      child: new ListView(
        
        children: <Widget>[
          
//          header
          new UserAccountsDrawerHeader(accountName: Text('mohamed'), accountEmail:Text('mmmmmmmmmmm'),
          currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(Icons.person, color: Color(0xfff8d008),),
              ),
            ),

            decoration: new BoxDecoration(
                color: Color(0xfff8d008)
              ),
          ),
          //      BODY
            
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("الصفحة الرئيسية",style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
                leading: Icon(Icons.home,color: Color(0xfff8d008),),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("حسابي",style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
                leading: Icon(Icons.person,color: Color(0xfff8d008),),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("طلباتي",style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
                leading: Icon(Icons.shopping_basket,color: Color(0xfff8d008),),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()),);
              },
              child: ListTile(
                title: Text("عربة التسوق",style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
                leading: Icon(Icons.shopping_cart,color: Color(0xfff8d008),),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("المفضلة",style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
                leading: Icon(Icons.favorite,color: Color(0xfff8d008),),
              ),
            ),

            Divider(),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("الإعدادات",style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
                leading: Icon(Icons.settings,color: Colors.black,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("حول",style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),),
                leading: Icon(Icons.help, color: Colors.blue,),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
              
              },
              child: ListTile(
                title: Text("تسجيل الخروج"),
                leading: Icon(Icons.lock_outline,color: Colors.black,),
              ),
            ),
        ],
      ),
      );
  }
}




 // var items = [];
  // @override
  // void initState(){
  //   super.initState();
  //   _getAllSliders();
  // }

  // _getAllSliders() async {
  //   var slider = await _sliderService.getSliders();
  //   var result = json.decode(slider.body);
  //  result['data'].forEach((data){
  //    setState(() {
  //      items.add(NetworkImage(data['slide_image']));
  //    });
  //  });
  //   print(result);
  // }