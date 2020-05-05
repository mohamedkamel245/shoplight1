import 'package:flutter/material.dart';
import 'package:shoplight/pages/homepage.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    Future.delayed(
      Duration(seconds: 3),
      (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>HomePage(),),);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.black),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(120.0),
                        child: Container(
                          
                          child: Image.asset('images/cats/Untitled-trr.png'),
                        ),

                      ),
                      // Padding(padding: EdgeInsets.only(top:1.0),),
                      // Text("متجر ضوء", style: TextStyle(color: Color(0xfff8d008)),)
                    ],
                  ),
                ),
              
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                         CircularProgressIndicator(
                          backgroundColor: Colors.amber,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text('تسوق مع متجر ضوء',
                      style: TextStyle(color: Colors.amber, fontSize: 18.0, fontWeight: FontWeight.bold),

                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}