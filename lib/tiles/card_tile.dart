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
      return Row(
        children: <Widget>[
          Container(
            width: 120.0,
            child: Image.network(
              cardProduct.productData?.images![0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  cardProduct.productData?.title ?? "",
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
                Text(
                  "Tamanho: ${cardProduct.size}",
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  "R\$ ${cardProduct.productData?.price?.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  )
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove)
                    ),
                    Text(cardProduct.quantity.toString()),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add)
                    ),
                    FlatButton(
                        onPressed: () {},
                        child: Text("Remover"),
                        textColor: Colors.grey.shade500,
                    ),
                  ],
                )
              ],
            )
          )
        ],
      );
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
