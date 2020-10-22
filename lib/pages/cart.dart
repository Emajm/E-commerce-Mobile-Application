import 'package:flutter/material.dart';
import 'package:marketing_app/components/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: new Center(child: new Text("Shopping Cart", textAlign: TextAlign.center)),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: (){}),
        ],
      ),
      body: new Cart_products(),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(title: new Text("Total:",style: TextStyle(fontSize: 18.0)),
              subtitle: new Text("\$230",style: TextStyle(fontSize: 16.0)),
              ),
            ),
            Expanded(child: MaterialButton(onPressed: (){},
            child: new Text("Check out",style: TextStyle(color: Colors.white,fontSize: 18.0),),color: Colors.red,))
          ],
        ),
      ),

    );
  }
}
