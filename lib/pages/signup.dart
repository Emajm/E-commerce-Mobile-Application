import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marketing_app/db/users.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   final _formKey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();
   TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _ConfirmPasswordController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  String gender;
  String groupValue = "male";
  bool hidePass = true;
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          /*Image.asset(
            'images/fashion.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),*/
//TODO:: make the logo show

          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
                alignment: Alignment.topCenter,
                child: Image.asset('images/cart.png', width: 120.0,
//                height: 240.0,
                )),
          ),

            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Form(
                    key: _formKey,
                    child: ListView(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left:12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _nameTextController,
                                  decoration: InputDecoration(
                                    hintText: "Full name",
                                    icon: Icon(Icons.person_outline),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "The name field cannot be empty";}
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                           color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left:12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _emailTextController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    icon: Icon(Icons.alternate_email),
                                    border: InputBorder.none,
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
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0,1.0,14.0,1.0),
                          child: Material(
                            elevation: 0.0,
                            color:  Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10.0),
                            /*child: Padding(
                              padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                              child: new Container(
                                //color:  Colors.white.withOpacity(0.4),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListTile(title: Text("male",
                                        textAlign: TextAlign.end,style: TextStyle(color: Colors.black),),
                                        trailing: Radio(value: "male", groupValue: groupValue,
                                            onChanged: (e)=> valueChanged(e)),

                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(title: Text("female", textAlign: TextAlign.end,style: TextStyle(color: Colors.black),),
                                        trailing: Radio(value: "female", groupValue: groupValue,
                                            onChanged: (e)=> valueChanged(e)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),*/
                          ),
                        ),
                        Padding(
                        //  padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                          padding: const EdgeInsets.fromLTRB(14.0,1.0,14.0,1.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left:12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _passwordTextController,
                                  obscureText: hidePass,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(Icons.lock_outline),
                                      border: InputBorder.none,

                                  ),
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "The password field cannot be empty";
                                    }else if(value.length < 6){
                                      return "the password has to be at least 6 characters long";
                                    }
                                    return null;
                                  },
                                ),
                                trailing: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){setState(() {
                                  if(hidePass==false){
                                  hidePass=true;
                                  }else{
                                    hidePass=false;
                                  }
                                });}),
                              ),
                            ),
                          ),
                        ),

                        /*(
                          padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left:12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _ConfirmPasswordController,
                                  obscureText: hidePass,
                                  decoration: InputDecoration(
                                    hintText: "Confirm password",

                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "The password field cannot be empty";
                                    }else if(value.length < 6){
                                      return "the password has to be at least 6 characters long";
                                    }else if(_passwordTextController.text != value){
                                      return "the password  and the confirmed password don't match";

                                    }
                                    return null;
                                  },
                                ),
                                trailing: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){setState(() {
                                  if(hidePass==false){
                                    hidePass=true;
                                  }else{
                                    hidePass=false;
                                  }
                                });}),

                              ),
                            ),
                          ),
                        ),*/

                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.deepOrange.shade700,
                              elevation: 0.0,
                              child: MaterialButton(onPressed: ()async{
                                validateForm();
                              },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text("Sign up", textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                              )
                          ),
                        ),

                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap:(){
                               Navigator.pop(context);
                              },
                              child: Text("I already have an account",textAlign: TextAlign.center,style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.w400,fontSize: 16.0),),

                            ),

//                            Text("Dont't have an accout? click here to sign up!",textAlign: TextAlign.end, style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w400, fontSize: 16.0),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0,1.0,14.0,1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Or Sing up with", style: TextStyle(fontSize: 20,color: Colors.grey),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  child: MaterialButton(
                                      onPressed: () {},
                                      child: Image.asset("images/fb1.png", width: 60,)
                                  )),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  child: MaterialButton(
                                      onPressed: () {},
                                      child: Image.asset("images/ggg.png", width: 60,)
                                  )),
                            )
                          ],

                        ),



              ]),
            ),
              )),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),

        )),

      ]),



    );
  }

  Future validateForm() async{
    FormState formState = _formKey.currentState;

    if(formState.validate()){
       //formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if(user == null){
       firebaseAuth.createUserWithEmailAndPassword(
            email: _emailTextController.text, password: _passwordTextController.text).then((user)=>
       {
        /* _userServices.createUser(
           {
             "username": _nameTextController.text,
              "email": _emailTextController.text,
               "userId": user.uid,

           }
           ),*/
           Firestore.instance.runTransaction((transaction) async {
          await transaction.set(Firestore.instance.collection("users").document(), {
            "username": _nameTextController.text,
            "email": _emailTextController.text,
            "password": _passwordTextController,
            "userId": user.uid,

         });
       })
       }).catchError((err)=>print(err.toString()));

    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => HomePage()));


      }
    }
  }
}


