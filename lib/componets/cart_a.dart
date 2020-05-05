import 'package:flutter/material.dart';

class Carta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                    onTap: () {},
                    child: Icon(Icons.keyboard_arrow_up)
                    ),
                  Text("0"),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.keyboard_arrow_down)
                    ),
                ],
              ),
            ),
            SizedBox(width: 20.0,),
            Container(
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/products/a2.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5.0,
                    offset: Offset(1.0, 0.0),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("مسك ضوء ضوء ضوء ضوء", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0),
                Text("SAR 65",style: TextStyle(color: Color(0xfff8d008),),),
               
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: (){},
              child: Icon(Icons.cancel, color: Colors.red),
              )
          ],
        ),
      ),
    );
  }
}