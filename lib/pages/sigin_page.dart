import 'dart:convert';
import 'package:shoplight/main.dart';
import 'package:flutter/material.dart';
import 'package:shoplight/models/api.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/pages/checkout_screen.dart';
import 'package:shoplight/pages/homepage.dart';
import 'package:shoplight/pages/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
    final List<ProductModel> cartItems;
  SignInPage({this.cartItems});

  @override
  _SignInPageState createState() => _SignInPageState();
}

enum LoginStatus{
  notSignIn,
  signIn
}

class _SignInPageState extends State<SignInPage> {
  
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String customer_email, customer_pass;
  final _key = GlobalKey<FormState>();

  bool _secureText = true;

  showHide(){
    setState((){
      _secureText = !_secureText;
    }

    );
  }

  check(){
    final form = _key.currentState;
    if(form.validate()){
      form.save();
      login();
    }
  }
  login() async{
    final response = await http.post("https://www.sh-oplight.com/api/login.php",
     body: {
      "customer_email" : customer_email,
      "customer_pass" : customer_pass
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value==1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value);
      });

      print(pesan);
    } else {
      print(pesan);
    }
    if (data == true) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setInt("userId", data['']);
    } else {
    }
    
  }

  savePref(int value)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.commit();
    });
  }

  var value;
  getPref()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value"); 

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {
    
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
      body: Stack(
        
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Color(0xfff8d008),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          Container(
            color: Colors.black,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'images/cats/Untitled-trr.png',
                width: 280.0,
                height: 240.0,
              )),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Center(
                child: Form(
                  key: _key,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              
                              child: TextFormField(
                               onSaved: (e) => customer_email = e,
                               textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                  labelText: "البريد الإكتروني",
                                  icon: Icon(Icons.alternate_email, color: Color(0xfff8d008),),
                                ),
                                validator: (e) {
                                  if (e.isEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(e))
                                      return 'يرجى التأكد من صحة عنوان بريدك الإلكتروني';
                                    else
                                      return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                obscureText: _secureText,
                                onSaved: (e) => customer_pass = e,
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                  labelText: "كلمة السر",
                                  
                                  suffixIcon: IconButton(icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility), 
                                  
                                  onPressed: showHide,),
                                  icon: Icon(Icons.lock_outline, color: Color(0xfff8d008),),
                                ),
                                
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "لا يمكن أن يكون حقل كلمة المرور فارغًا";
                                  } else if (e.length < 6) {
                                    return "يجب أن تتكون كلمة المرور من 6 أحرف على الأقل";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0xfff8d008),
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () {
                                  check();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  "تسجيل الدخول",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              )
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "هل نسيت كلمة المرور",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
//                          Expanded(child: Container()),

                        Padding(
                            padding: const EdgeInsets.only(left: 140.0),
                            
                            child: RichText(text: TextSpan(
                              style: TextStyle(color: Colors.white,),
                              children: [
                                TextSpan(
                                  text: "ليس لديك حساب؟ انقر هنا"
                                ),
                                
                              ],
                              ),
                              ),
                        ),
                        
                        FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp(cartItems: this.widget.cartItems,)));
                  },
                  child: FittedBox(child: Text("التسجيل", textAlign: TextAlign.center, style: TextStyle(color: Color(0xfff8d008),),)),
                ),
                      ],
                    )),
              ),
            ),
          ),
         
        ],
      ),
    );
        break;
      case LoginStatus.signIn:
        return CheckoutScreen(cartItems: this.widget.cartItems,);
        
      break;
    }
    
  }
}

