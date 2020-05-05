import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/pages/cart.dart';

class CartButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 150,
            width: 30,
             child: Stack(
               children: <Widget>[
                 IconButton(
                   iconSize: 25,
                   icon: Icon(Icons.shopping_cart, color: Colors.amber,), onPressed: (){
                     
                   }),
                   Positioned(
                     child: Stack(
                     children: <Widget>[
                       Icon(Icons.brightness_1, size: 20, color: Colors.red),
                       Positioned(
                         top: 2.0,
                         right: 7.0,
                         child: Center(child: Text('0'),
                         )
                         ),
                     ],
                   ),
                   ),
               ],
             ),
          ),
        )
       
        
        
      ],
    );
  }
}





class Cart_text extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: new AppBar(
        backgroundColor: Colors.black,
        title: Text('عربة التسوق', style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text("...عربة السلة فارغة",style: TextStyle(color: Colors.black,fontSize: 20.0),),
      ),
    );
  }
}



        //   StreamBuilder(
        //   stream: bloc.ListStream,
        //  builder: (context, snapshot){
        //    List<ProductModel> productmodels = snapshot.data;
        //    int lenght = productmodels != null ? productmodels.length : 0;

        //    return buildGestureDetector(lenght, context,productmodels);
        //  },
        // )