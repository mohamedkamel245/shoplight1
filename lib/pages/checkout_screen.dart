import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/models/shipping.dart';
import 'package:shoplight/pages/homepage.dart';
import 'package:shoplight/pages/payment_screen.dart';
import 'package:shoplight/services/shipping_address.dart';

class CheckoutScreen extends StatefulWidget {
  final List<ProductModel> cartItems;
  
  CheckoutScreen({this.cartItems});



  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _city = TextEditingController();
  final _region = TextEditingController();
  final _streetnumber = TextEditingController();
  final _buildingnumber = TextEditingController();
  final _titletype = TextEditingController();
  final _mobilenumber  = TextEditingController();
 

_showSnackMessage(message){
  var snackBar = SnackBar(content: message,);
  _scaffoldkey.currentState.showSnackBar(snackBar);
}
 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(

        title: Text('الدفع'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 28.0, right: 28.0, bottom: 14.0),
            child: Text('عنوان الشحن',
            textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _name,
              decoration: InputDecoration(hintText: 'الاسم كامل',
              
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: InputDecoration(hintText: 'البريد الاكتروني'),
              textDirection: TextDirection.rtl,
            ),
            
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _city,
              decoration: InputDecoration(hintText: 'المدنية',
              
              ),
              textDirection: TextDirection.rtl,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _region,
              decoration: InputDecoration(hintText: 'المنطقة',
              
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
         Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _streetnumber,
              decoration: InputDecoration(hintText: 'رقم الشارع',
              
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _buildingnumber,
              decoration: InputDecoration(hintText: 'رقم العمارة',
              
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
         Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _titletype,
              decoration: InputDecoration(hintText: 'نوع العنوان',
              
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: _mobilenumber,
              decoration: InputDecoration(hintText: 'رقم الموبايل',
              
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          
        ],
      ),
      bottomNavigationBar: Container(
        child: ButtonTheme(
          minWidth: 320.0,
          height: 45.0,
          child: FlatButton(
            color: Color(0xfff8d008),
            onPressed: () async {
              var shipping = Shipping();
              shipping.name = _name.text;
              shipping.username = _email.text;
              shipping.city = _city.text;
              shipping.region = _region.text;
              shipping.streetnumber = _streetnumber.text;
              shipping.buildingnumber = _buildingnumber.text;
              shipping.titletype = _titletype.text;
              shipping.mobilenumber = _mobilenumber.text;
              shipping.cartItems = this.widget.cartItems;
              _addShipping(context, shipping);
                          },
                          child: Text('تاكيد الطلب ', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900)),
                        ),
                      ),
                    ),
                  );
                }
              
                void _addShipping(BuildContext context, Shipping shipping) async {
                  ShippingService _shippingService = ShippingService();
                  var shippingData = await _shippingService.addShipping(shipping);
                  var result = json.decode(shippingData.body);
                  if (result == true) {
                    _showShippingSuccessMessage(context);
                                        Timer(Duration(seconds: 2),(){
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()) );
                                        }
                    
                                        );
                                        
                                      }
                                    }
                    
                      _showShippingSuccessMessage(BuildContext context) {
                        return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/cats/success.png'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ' تم الطلب بالنجاح لحظات وطلبك يكون جاهز !',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        });

                      }
}
