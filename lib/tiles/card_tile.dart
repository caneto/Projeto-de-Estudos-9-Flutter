import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/card_product.dart';
import 'package:lojavirtual/datas/product_data.dart';

class CardTile extends StatelessWidget {

  final CardProduct cardProduct;

  CardTile(this.cardProduct, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent() {
      return Container();
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cardProduct.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("products").doc(cardProduct.category).collection('itens')
              .doc(cardProduct.pid).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cardProduct.productData = ProductData.fromDocument(snapshot.data);
              return _buildContent();
            } else {
              return Container(
                height: 70.0,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          }
        ) :
        _buildContent()
    );
  }
}
