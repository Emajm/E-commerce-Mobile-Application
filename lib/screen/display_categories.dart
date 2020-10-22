import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'category.dart';

class displayCategory extends StatefulWidget {
  @override
  _displayCategoryState createState() => _displayCategoryState();
}

class _displayCategoryState extends State<displayCategory> {
  CategoryService categoryService = new CategoryService();
  int index;
  List<DropdownMenuItem<String>> categoriesDropDown = <DropdownMenuItem<String>>[];
  Firestore _firestore = Firestore.instance;
  String ref = "categories";
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  @override
  List<DropdownMenuItem<String>> getCategoriesDropdown(){
    List<DropdownMenuItem<String>> items = new List();
    for(int i = 0; i < categories.length; i++){
     /*setState(() {
        items.insert(0, DropdownMenuItem(child: Text(categories[i].data['category']),
            value: categories[i].data['category']));
      });*/

    }
    return items;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white,
          leading: Icon(Icons.close, color: Colors.black,),
          title: Text("Categories", style: TextStyle(color: Colors.black),),
        ),
        body:
        Center(
          child: Container(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('categories')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        children: snapshot.data.documents.map((DocumentSnapshot document) {
                          return new Column(
                           children: <Widget>[
                             new Text(document['category'],style: TextStyle(fontSize: 20,color: Colors.blue),),

                           ],
                          );
                        }).toList(),
                      );
                  }
                },
              )),
        ),
    );
  }
}


