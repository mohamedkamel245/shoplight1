import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shoplight/pages/homepage.dart';
import 'package:shoplight/widgets/splash_sceen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
    
  }
    
}