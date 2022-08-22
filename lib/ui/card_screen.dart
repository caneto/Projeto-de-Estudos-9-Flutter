import 'package:flutter/material.dart';
import 'package:lojavirtual/models/card_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/ui/login_screen.dart';
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
      body: ScopedModelDescendant<CardModel>(
        builder: (context,child, model) {
          if(model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(child: CircularProgressIndicator(),);
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor),
                  SizedBox(height: 16.0,),
                  Text("Faça o login para adicionar produtos!",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0,),
                  RaisedButton(
                    child: Text("Entrar", style: TextStyle(fontSize: 18.0,)),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    }
                  )
                ],
              ),
            );
          } else if (model.products == null && model.products.length == 0) {
            return Center(child: Text("Nenhum produto no Carrinho",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            );
          }
          return Container();
        }
      ),
    );
  }
}
