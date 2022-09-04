import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/tiles/cart_tile.dart';
import 'package:lojavirtual/ui/login_screen.dart';
import 'package:lojavirtual/ui/order_screen.dart';
import 'package:lojavirtual/widgets/cart_price.dart';
import 'package:lojavirtual/widgets/custom_mensagem.dart';
import 'package:lojavirtual/widgets/discount_card.dart';
import 'package:lojavirtual/widgets/ship_cart.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                  "${p != 0 ? p: "0"} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                );
              }
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context,child, model) {
          if(model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(child: CircularProgressIndicator(),);
          } else if (!UserModel.of(context).isLoggedIn()) {
            CustomMensagem("Faça o login para adicionar produtos!",0);
          } else if (model.products.isEmpty && model.products.length == 0) {
            return Center(child: Text("Nenhum produto no Carrinho",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map(
                    (product) {
                      return CartTile(product);
                    }
                  ).toList(),
                ),
                DiscountCard(),
                ShipCard(),
                CartPrice(() async {
                  String? orderId = await model.finishOrder();
                  if(orderId != null)
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=>OrderScreen(orderId))
                    );
                })
              ],
            );
          }
          return Container();
        }
      ),
    );
  }
}
