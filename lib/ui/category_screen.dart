import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.get('title')),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),)
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection("products").doc(snapshot.id).collection('itens')
              .get(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(color: Colors.red),
                  Container(color: Colors.green)
                ],
              )
            }
          },
        ),
      ),
    );
  }
}
