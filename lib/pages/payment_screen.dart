import 'package:flutter/material.dart';
import 'package:shoplight/models/productModel.dart';

class PaymentScreen extends StatefulWidget {
  final List<ProductModel> cartItems;
  
  PaymentScreen({this.cartItems});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}