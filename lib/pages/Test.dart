import 'package:flutter/material.dart';
class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('images/products/pants2.jpeg',fit: BoxFit.cover,width: double.infinity,),
           Container(
             //alignment: Alignment.topCenter,
              // child: Image.asset('images/lg.png', width: 280.0, height: 240.0,),
           color: Colors.red.withOpacity(0.2),
             width: double.infinity,
             height: double.infinity,
           ),
          Container(
            alignment: Alignment.center,
            child: Center(
              key: _formKey,
             child: Form(child: Column(
                 children: <Widget>[
                   TextFormField(
                     controller: _emailTextController,
                     decoration: InputDecoration(
                       hintText: "Email",
                       icon: Icon(Icons.alternate_email),
                     ),

                     validator: (value) {
                       if (value.isEmpty) {
                         Pattern pattern =
                             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                         RegExp regex = new RegExp(pattern);
                         if (!regex.hasMatch(value))
                           return 'Please make sure your email address is valid';
                         else
                           return null;
                       }
                     },
                   ),
                 ],
               ),
             ),
            ),
          ),
          Visibility(
           // visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.7),
                child: CircularProgressIndicator(
                  valueColor:  AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child:    Center(
          child: Padding(
            padding: const EdgeInsets.only(left:12.0,right:12.0,top: 8.0,bottom: 8.0),
            child: FlatButton(
                color: Colors.red.shade900,
                onPressed: (){

                }, child: Text("Sign in /Sign up with google",style: TextStyle(color: Colors.white),)),
          ),
        ),
      ),
    );
  }
}
