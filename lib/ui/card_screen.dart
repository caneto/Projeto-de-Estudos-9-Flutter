import 'package:flutter/material.dart';
import 'package:lojavirtual/models/card_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CardModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
