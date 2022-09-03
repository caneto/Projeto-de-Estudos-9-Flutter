import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      child: ExpansionTile(
        title: Text("Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom"
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance.collection("coupons").doc(text).get().then((docSnap) {
                  if(docSnap.data() != null) {
                    CartModel.of(context).setCoupon(text,docSnap.data()!['percent']);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Desconto de ${docSnap.data()!['percent']}% aplicado"),
                          backgroundColor: Theme.of(context).primaryColor,
                          duration: Duration(seconds: 2),
                        )
                    );
                  } else {
                    CartModel.of(context).setCoupon("",0);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Cupom não existente"),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(seconds: 2),
                        )
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
