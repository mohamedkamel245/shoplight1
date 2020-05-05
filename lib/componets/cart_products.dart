import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/pages/checkout_screen.dart';
import 'package:shoplight/pages/login_screen.dart';
import 'package:shoplight/pages/sigin_page.dart';
import 'package:shoplight/services/cart_service.dart';

class Cart_products extends StatefulWidget {
  final List<ProductModel> cartItems;
  Cart_products(this.cartItems);
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartService _cartService = CartService();
  double _total;

 @override
  void initState() {
    super.initState();
    _getTotal();
  }


  _getTotal() {
    _total = 0.0;
    this.widget.cartItems.forEach((item) {
      setState(() {
        _total += (item.product_price - item.product_sale) * item.product_quantity;
      });
    });
  }

  void _checkOut(List<ProductModel> cartItems) async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
    int _userId = _prefs.getInt('userId');
    if (_userId != null && _userId > 0) {
      // navigate to checkout screen
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutScreen(cartItems: cartItems)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInPage(cartItems: cartItems)));
    }
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
     _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Row(
          
          children: <Widget>[
           
            Image.asset('images/cats/Untitled-trr1.png'),
           Text('عربة التسوق', style: TextStyle(color: Color(0xfff8d008))),
              
        ],
        
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
          scrollDirection: Axis.vertical,
        itemCount: this.widget.cartItems.length,
        itemBuilder: (context, index){
          return Dismissible(
            key: Key(this.widget.cartItems[index].product_id.toString()),
            onDismissed: (param){
             _deleteCartItem(index, this.widget.cartItems[index].product_id.toString());
                          },
                          background: Container(
                            color: Color(0xfff8d008),
                          ),
                                    child: Card(
                    child: Padding(
                      
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 75.0,
                              width: 45.0,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2.0, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _total +=
                                      this.widget.cartItems[index].product_price - this.widget.cartItems[index].product_sale;
                                      this.widget.cartItems[index].product_quantity++;
                                      });
                                    },
                                    child: Icon(Icons.keyboard_arrow_up)
                                    ),
                                  Text('${this.widget.cartItems[index].product_quantity}'),
                                  InkWell(
                                    onTap: () {
              
                                      setState(() {
                                        if(this.widget.cartItems[index].product_quantity > 1){
                                           _total -=
                                      this.widget.cartItems[index].product_price - this.widget.cartItems[index].product_sale;
                                      this.widget.cartItems[index].product_quantity--;
                                        }
                                       
                                      });
                                    },
                                    child: Icon(Icons.keyboard_arrow_down)
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://www.sh-oplight.com/admin_area/product_images/'+widget.cartItems[index].product_img1),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 0.0,
                                    offset: Offset(.00, 0.0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5.0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                
                                Text(
                                  
                                  this.widget.cartItems[index].product_title,
                                  textDirection: TextDirection.rtl,
                                   style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w900),
                                overflow: TextOverflow.ellipsis,
                                
                                ),
                                SizedBox(height: 10.0),
                                
                                 Row(
                                 children: <Widget>[
                                   Text('${this.widget.cartItems[index].product_price - this.widget.cartItems[index].product_sale} ريال',
                                   textDirection: TextDirection.rtl,
                                   style: TextStyle(),),
                               Text('X'),
                               Text('${this.widget.cartItems[index].product_quantity}',
                                      style:
                                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                          Text('='),
                                          Text('${(this.widget.cartItems[index].product_price - this.widget.cartItems[index].product_sale) * this.widget.cartItems[index].product_quantity} ريال',
                                          textDirection: TextDirection.rtl,
                                      style:
                                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Color(0xfff8d008),),
                                    )
                                 ],
                                 
                               ),
              
                              ],
                            ),
                            
                          ],
                      ),
                    ),
                  ),
                        );
                        
                      }
                    ),
              
                    bottomNavigationBar: Container(
                      child: Container(
                    height: 220.0,
                    margin: EdgeInsets.only(top:20.0),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("$_total ريال",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 17.0,color: Colors.black, fontWeight: FontWeight.bold, ),),
                            Text("مجموع عربة السلة", style: TextStyle(fontSize: 17.0,color: Colors.grey, fontWeight: FontWeight.bold, ),),
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("0.0",style: TextStyle(fontSize: 17.0,color: Colors.black, fontWeight: FontWeight.bold, ),),
                            Text("خصم", style: TextStyle(fontSize: 17.0,color: Colors.grey, fontWeight: FontWeight.bold, ),),
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("0.0",style: TextStyle(fontSize: 17.0,color: Colors.black, fontWeight: FontWeight.bold, ),),
                            Text("الشحن", style: TextStyle(fontSize: 17.0,color: Colors.grey, fontWeight: FontWeight.bold, ),),
                          ]
                        ),
                        Divider(height: 20.0, color: Colors.grey,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            
                            Text('$_total ريال',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 17.0,color: Colors.black, fontWeight: FontWeight.bold, ),),
                            Text("المجموع الكلي", style: TextStyle(fontSize: 17.0,color: Colors.grey, fontWeight: FontWeight.bold, ),),
                          ]
                        ),
                        SizedBox(
                          height: 20.0,
                          ),
                          GestureDetector(
                            onTap: (){
                              _checkOut(this.widget.cartItems);
                            },
                          
                         child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Color(0xfff8d008),
                          ),
                          child: Center(
                            
                            child: Text("تابع عملية الشراء", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w900),),
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                    ),
                  );
                  
              }
              
                Future _deleteCartItem(int index, dynamic product_id) async {
                  setState(() {
                    this.widget.cartItems.removeAt(index);
                  });
                  // delete item by id from local database
    var result = await _cartService.deleteCartItemById(product_id.toString());
    if (result > 0) {
      
      _showSnackMessage(Text(
        'تم حذف عنصر واحد من سلة التسوق',
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Colors.red),
      ));
    } else {
      _showSnackMessage(Text(
        'لا يمكن حذف عناصر سلة التسوق!',
        style: TextStyle(color: Colors.yellow),
      ));
    }
                }

 }