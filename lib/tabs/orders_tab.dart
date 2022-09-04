import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/tiles/order_title.dart';
import 'package:lojavirtual/ui/home_screen.dart';
import 'package:lojavirtual/widgets/custom_mensagem.dart';

class OrdersTab extends StatelessWidget {
  OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(UserModel.of(context).isLoggedIn()) {
      String? uid = UserModel.of(context).firebaseUser?.uid;

      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("users").doc(uid)
            .collection("orders").get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.length == 0) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add_shopping_cart, size: 80.0, color: Theme
                      .of(context)
                      .primaryColor),
                  SizedBox(height: 16.0,),
                  Text("Carrinho vazio favor voltar!",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0,),
                  ElevatedButton(
                    style: raisedButtonStyle,
                    child: Text(
                        "Voltar", style: TextStyle(fontSize: 18.0,)),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  )
                ],
              ),
            );
        } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) => OrderTile(doc.id)).toList()
                  .reversed.toList(),
            );
          }
        },
      );

    } else {
      return CustomMensagem("Faça o login para acompanhar!",1);
    }
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.blue.shade400,
    textStyle: TextStyle(color: Colors.white),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

}
