import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoplight/models/api.dart';
import 'package:shoplight/models/productModel.dart';
import 'package:shoplight/pages/sigin_page.dart';

class SignUp extends StatefulWidget {
   final List<ProductModel> cartItems;
  SignUp({this.cartItems});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
String customer_email, customer_pass, customer_name;
final _key = new GlobalKey<FormState>();

 bool _secureText = true;

  showHide(){
    setState((){
      _secureText = !_secureText;
    }

    );
  }

  check(){
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save()async{
    final response = await http.post("https://www.sh-oplight.com/api/register.php",
     body: {
       
      "customer_name" : customer_name,
      "customer_email" : customer_email,
      "customer_pass" : customer_pass
    }
    );
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 2) {
      setState((){
        Navigator.pop(context);
      });
    } else {
      print(pesan);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
         
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
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "لا يمكن أن يكون حقل الاسم فارغًا";
                                  }
                                },
                                onSaved: (e) => customer_name = e,
                                decoration: InputDecoration(
                                    hintText: " الأسم ",
                                    icon: Icon(Icons.person_outline, color: Colors.amber,),
                                    border: InputBorder.none),
                                
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
                                onSaved: (e) => customer_email = e,
                                decoration: InputDecoration(
                                    hintText: "البريد الاكتروني",
                                    icon: Icon(Icons.alternate_email, color: Colors.amber,),
                                    border: InputBorder.none),
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return 'يرجى التأكد من صحة عنوان بريدك الإلكتروني';
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
                              child: ListTile(
                                title: TextFormField(
                                  obscureText: _secureText,
                                  onSaved: (e) => customer_pass = e,
                                  decoration: InputDecoration(
                                      hintText: "كلمة المرور",
                                      icon: Icon(Icons.lock_outline,color: Colors.amber,),
                                      border: InputBorder.none),
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
                        ),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        //   child: Material(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //     color: Colors.white.withOpacity(0.4),
                        //     elevation: 0.0,
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(left: 12.0),
                        //       child: TextFormField(
                        //         onSaved: (e) => address = e,
                        //         decoration: InputDecoration(
                        //             hintText: "العنوان كامل",
                        //             icon: Icon(Icons.adb, color: Colors.amber,),
                        //             border: InputBorder.none),
                        //         validator: (e) {
                        //           if (e.isEmpty) {
                        //             return 'يرجي منك كتابة عنوان كامل لاجل توصل طلباتك';
                        //           }
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),

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
                                  "التسجيل",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "تسجيل الدخول",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.amber),
                                ))),
                      ],
                    )
                    ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  

 
}