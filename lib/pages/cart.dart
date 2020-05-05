import 'package:flutter/material.dart';
import 'package:shoplight/componets/cart_a.dart';

import 'package:shoplight/componets/cart_products.dart';
import 'package:shoplight/pages/sigin_page.dart';




class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Text('عربة التسوق', style: TextStyle(color: Colors.amber),),
        centerTitle: true,
        elevation: 0.0,
         actions: <Widget>[
          // new IconButton(icon: Icon(Icons.search,color: Color(0xfff8d008),),onPressed: (){}),
        ],
      ),

        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          scrollDirection: Axis.vertical,
          children: <Widget>[
              new Carta(),
              new Carta(),
              new Carta(),
              new Carta(),
              new Carta(),
              new Carta(),
              new Carta(),
           
          ],
        ),
        bottomNavigationBar:  _buildTotalContainer(),
      
    );
  }
  Widget _buildTotalContainer(){
    return Container(
      height: 220.0,
      margin: EdgeInsets.only(top:20.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("65.0",style: TextStyle(fontSize: 17.0,color: Colors.black, fontWeight: FontWeight.bold, ),),
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
              Text("65.0",style: TextStyle(fontSize: 17.0,color: Colors.black, fontWeight: FontWeight.bold, ),),
              Text("المجموع الكلي", style: TextStyle(fontSize: 17.0,color: Colors.grey, fontWeight: FontWeight.bold, ),),
            ]
          ),
          SizedBox(
            height: 20.0,
            ),
            GestureDetector(
              onTap: (){
                // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SignInPage()));
              },
            
           child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Center(
              child: Text("تابع عملية الشراء", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
            ),
          ),
          ),
        ],
      ),
    );
  }
}