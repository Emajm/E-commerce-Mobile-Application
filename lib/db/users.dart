import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marketing_app/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class UserServices{
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "utilisateurs";

  createUser(Map value){
   // _database.reference().child(ref).push().set(value).catchError((e)=> {print(e.toString())});

  }
}