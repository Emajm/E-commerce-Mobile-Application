import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_te_cart = [
    {
      "name":"Blazer",
      "picture":"images/products/blazer1.jpeg",
      "price":85,
      "size" :"M",
      "color":"Red",
      "quantity": 1,
    },
    {
      "name":"Blazer two",
      "picture":"images/products/blazer2.jpeg",
      "price":78,
      "size" :"M",
      "color":"Red",
      "quantity": 1,
    },
    {
      "name":"pants",
      "picture":"images/products/pants1.jpg",
      "price":55,
      "size" :"M",
      "color":"Red",
      "quantity": 1,
    },
    {
      "name":"skt",
      "picture":"images/products/skt2.jpeg",
      "price":50,
      "size" :"M",
      "color":"Red",
      "quantity": 1,
    },

  ];
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: Products_on_te_cart.length,
        itemBuilder:(context,index){
          return Single_cart_product(
            cart_prod_name: Products_on_te_cart[index]['name'],
            cart_prod_picture: Products_on_te_cart[index]['picture'],
            cart_prod_price: Products_on_te_cart[index]['price'],
            cart_prod_color: Products_on_te_cart[index]['color'],
            cart_prod_size: Products_on_te_cart[index]['size'],
            cart_prod_qty: Products_on_te_cart[index]['quantity'],
          );
        });
  }
}
class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  const Single_cart_product({Key key, this.cart_prod_name, this.cart_prod_picture, this.cart_prod_price, this.cart_prod_size, this.cart_prod_color, this.cart_prod_qty}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(

        leading: new Image.asset(cart_prod_picture,width:   80.0,height: 80.0,),
        title: new Text(cart_prod_name,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),
        subtitle: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
               /* Expanded(
                  child: new Text("Size:   ${cart_prod_size}",style: TextStyle(fontWeight: FontWeight.bold),),
                ),*/
               Padding(
                 padding: const EdgeInsets.all(0.0),
                child: new Text("Size:",style: TextStyle(fontWeight: FontWeight.bold,fontSize:18.0)),
               ),
               Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: new Text(cart_prod_size,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
               ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(20.0,8.0,8.0,8.0),
                 child: new Text("Color:",style: TextStyle(fontWeight: FontWeight.bold,fontSize:18.0)),
               ),
               Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: new Text(cart_prod_color,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
               ),
              /*  Expanded(
                  child: new Text("Color: ${cart_prod_color}",style: TextStyle(fontWeight: FontWeight.bold)),
                ),*/
              ],
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                "\$${cart_prod_price}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0,color: Colors.red),
              ),
            ),
          ],
        ),
        trailing: new Column(
          children: <Widget>[
            new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
           new Text("${cart_prod_qty}"),
            new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
          ],
        ),
      ),
    );
  }
}
