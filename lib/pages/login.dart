import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marketing_app/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _controller = new PageController();
  @override
  void initState() {
    super.initState();

    isSignedIn();
    // une autre fonction pour le login
    /*getUser().then((user) {
      if (user != null) {
        // send the user to the home page
        // homePage();
      }
    });*/
  }


  void signInWithEmail() async {
    // marked async
    FirebaseUser user;
    try {
      user = await _auth.signInWithEmailAndPassword(
          email: _emailTextController.text, password: _passwordTextController.text);
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        // sign in successful!
        // ex: bring the user to the home page
      } else {
        // sign in unsuccessful
        // ex: prompt the user to try again
      }
    }
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }
  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    FirebaseUser user = await firebaseAuth.currentUser();
    print(user.email);
    //preferences = await SharedPreferences.getInstance();
   // isLogedin = await googleSignIn.isSignedIn();

    await firebaseAuth.currentUser().then((user){

      if(user != null){

         setState(()=> isLogedin=true);
      }
    });
    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DetailPage(HomePage())));
    }
    setState(() {
      loading = false;
    });
  }
// -----------------------------------------------------------------------------------------------------------------
  /*Future handleSignInEmail()async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    setState(() {
      loading = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    if (firebaseUser != null) {
   } else {
  Fluttertoast.showToast(msg: "Login failed :(");
  }
  } */

  // -----------------------------------------------------------------------------------------------------------------
  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    //------------------------------ // partie Sign in with Google---------------------------------------------------
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleUser.authentication;
   /* FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);*/
    FirebaseUser firebaseUser = await firebaseAuth.signInWithEmailAndPassword(
        email: googleSignInAuthentication.idToken, password: googleSignInAuthentication.accessToken);

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
//          insert the user to our collection
        Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "profilePicture": firebaseUser.photoUrl
        });

        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoUrl", firebaseUser.displayName);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("photoUrl", documents[0]['photoUrl']);
      }

      Fluttertoast.showToast(msg: "Login was successful");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Fluttertoast.showToast(msg: "Login failed :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      body: Stack(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(120.0),
            child: Container(
                alignment: Alignment.topCenter,
                child: Image.asset('images/cart.png', width: 120.0,)),
          ),


          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: Center(
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.2),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left:12.0),
                              child: TextFormField(
                                controller: _emailTextController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
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
                              child: TextFormField(
                                controller: _passwordTextController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  icon: Icon(Icons.lock_outline),
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
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0,8.0,14.0,8.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                               color: Colors.deepOrange.shade700,
                              elevation: 0.0,

                              child: MaterialButton(onPressed: (){
                                isSignedIn();
                                //signInWithEmail();
                              },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text("Login", textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                              )
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Text("Forgot password", textAlign: TextAlign.center, style: TextStyle(color: Colors.black,  fontWeight: FontWeight.w400,fontSize: 16.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                                  },
                                  child: Text("Create an account", textAlign: TextAlign.center, style: TextStyle(color: Colors.black,  fontWeight: FontWeight.w400,fontSize: 16.0),)),

                            ),
                          ],

                        ),


                        Text("Other login in opntion",textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                  child: InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                                      },
                                      child: Text("Or", textAlign: TextAlign.center, style: TextStyle(color: Colors.black,  fontWeight: FontWeight.w400,fontSize: 16.0),)),

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
                                    ),
                                  ],
                                ),

                              ],
                            )
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),

          /*Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )*/
        ],

      ),
    );
  }



}


