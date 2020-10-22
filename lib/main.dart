import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:marketing_app/components/horizontal_listview.dart';
import 'package:marketing_app/components/products.dart';
import 'package:marketing_app/pages/Test.dart';
import 'package:marketing_app/pages/cart.dart';
import 'package:marketing_app/pages/home.dart';

import 'package:marketing_app/pages/login.dart';
import 'package:marketing_app/pages/signup.dart';
import 'package:marketing_app/screen/admin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedWhite',
      theme: ThemeData(
       // primarySwatch: Colors.red.shade900,
        primarySwatch: Colors.blue,
      ),
      home:  Login(),
    );
  }
}
