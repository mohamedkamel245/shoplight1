
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shoplight/models/productModel.dart';
// import 'package:shoplight/models/user.dart';
// import 'package:shoplight/pages/checkout_screen.dart';
// import 'package:shoplight/pages/registration_screen.dart';
// import 'package:shoplight/pages/signup_page.dart';
// import 'package:shoplight/services/user_service.dart';

// class LoginScreen extends StatefulWidget {
//   final List<ProductModel> cartItems;
//   LoginScreen({this.cartItems});
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final email = TextEditingController();
//   final password = TextEditingController();
// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


//   _login(BuildContext context, User user) async {
//     var _userService = UserService();
//     var registeredUser = await _userService.login(user);
//     print(registeredUser.body);
//     var result = json.decode(registeredUser.body);
    
//     if(result == true){
//       SharedPreferences _prefs = await SharedPreferences.getInstance();
//       _prefs.setInt('userId', result['user']['customer_id']);
//       _prefs.setString('userName', result['user']['customer_name']);
//       _prefs.setString('userEmail', result['user']['customer_email']);
//       Navigator.push(
//             context, MaterialPageRoute(builder: (context) => CheckoutScreen(cartItems: this.widget.cartItems,)));
//     } else {
//       _showSnackMessage(Text('Failed to login!', style: TextStyle(color: Colors.red),));
//     }
//   }

//   _showSnackMessage(message){
//     var snackBar = SnackBar(
//       content: message,
//     );
//     _scaffoldKey.currentState.showSnackBar(snackBar);
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.close,
//               color: Colors.red,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 120),
//         child: ListView(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
//               child: TextField(
//                 controller: email,
//                 decoration: InputDecoration(
//                   hintText: 'youremail@example.com', labelText: 'Enter your email'
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
//               child: TextField(
//                 controller: password,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your password', labelText: '******'
//                 ),
//               ),
//             ),
//             Column(
//               children: <Widget>[
//                 ButtonTheme(
//                   minWidth: 320,
//                   height: 45.0,
//                   child: FlatButton(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0)),
//                     color: Colors.redAccent,
//                     onPressed: () {
//                       var user = User();
//                       user.customer_email = email.text;
//                       user.customer_pass = password.text;
//                       _login(context, user);
//                     },
//                     child: Text(
//                       'Log in',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),

//                 FlatButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => SignUp(cartItems: this.widget.cartItems,)));
//                   },
//                   child: FittedBox(child: Text('Register your account')),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
