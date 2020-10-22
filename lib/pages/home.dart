import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:marketing_app/components/horizontal_listview.dart';
import 'package:marketing_app/components/products.dart';
import 'package:marketing_app/pages/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child:  Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
          AssetImage('images/m2.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: new Center(child: new Text("ShopApp", textAlign: TextAlign.center)),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: (){}),
          new IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,), onPressed: (){
            Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new Cart()));
          })
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //     header
            new UserAccountsDrawerHeader(accountName: Text('DOUAIDI Lydia'), accountEmail: Text('gl_douaidi@esi.dz'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage : new AssetImage('images/a.jpg') ,
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.red,
              ),
            ),
            //      body
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home,color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person,color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket,color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new Cart()));
              },
              child: ListTile(
                title: Text('Shopping cart'),
                leading: Icon(Icons.shopping_cart,color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite,color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Settigns'),
                leading: Icon(Icons.settings,color: Colors.blue,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help,color: Colors.green,),
              ),
            ),
            InkWell(
              onTap: (){
                SignOut();
              },
              child: ListTile(
                title: Text('Sign Out'),
                leading: Icon(Icons.account_box,color: Colors.grey,),
              ),
            ),
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          image_carousel,
          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text('Categories'),),
          // Horizontal List View Begins here
          HorizontalList(),
          new Padding(padding: const EdgeInsets.all(20.0),
            child: new Text('Recent products'),),
          // grid view
          Container(
            height: 320.0,
            child: Products(),
          ),
        ],
      ),
    );
  }
  Future <Login> SignOut()  async{
    await FirebaseAuth.instance.signOut();

    return new Login();
  }
}

