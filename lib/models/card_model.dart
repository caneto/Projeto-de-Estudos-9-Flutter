
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/card_product.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CardModel extends Model {

  UserModel? user;

  List<CardProduct> products = [];

  bool isLoading = false;

  CardModel(this.user);

  static CardModel of(BuildContext context) =>
      ScopedModel.of<CardModel>(context);

  void addCardItem(CardProduct cardProduct) {
    products.add(cardProduct);

    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.firebaseUser?.uid)
        .collection("card")
        .add(cardProduct.toMap()).then((doc) {
          cardProduct.cid = doc.id;
        });

    notifyListeners();
  }

  void removeCardItem(CardProduct cardProduct) {

     FirebaseFirestore.instance
        .collection("users")
        .doc(user?.firebaseUser?.uid)
        .collection("card")
        .doc(cardProduct.cid).delete();

     products.remove(cardProduct);
     notifyListeners();
  }
}