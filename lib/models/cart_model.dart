
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/cart_product.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  UserModel? user;

  List<CartProduct> products = [];

  bool isLoading = false;


  String? couponCode;
  int discountPercentage = 0;

  String _users="users";
  String _cart ="cart";

  CartModel(this.user) {
    if(user!.isLoggedIn())
      _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    FirebaseFirestore.instance
        .collection(_users)
        .doc(user?.firebaseUser?.uid)
        .collection(_cart)
        .add(cartProduct.toMap()).then((doc) {
          cartProduct.cid = doc.id;
        });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {

     FirebaseFirestore.instance
        .collection(_users)
        .doc(user?.firebaseUser?.uid)
        .collection(_cart)
        .doc(cartProduct.cid).delete();

     products.remove(cartProduct);
     notifyListeners();
  }

  void decProduct(CartProduct cartProduct){
    if(cartProduct != null) cartProduct.quantity--;

    FirebaseFirestore.instance
        .collection(_users).doc(user?.firebaseUser?.uid)
        .collection(_cart)
        .doc(cartProduct.cid).update(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;

    FirebaseFirestore.instance
        .collection(_users).doc(user?.firebaseUser?.uid)
        .collection(_cart)
        .doc(cartProduct.cid).update(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void _loadCartItems() async {

    QuerySnapshot query = await FirebaseFirestore.instance.collection(_users).doc(user?.firebaseUser?.uid)
        .collection(_cart)
        .get();

    products = query.docs.map((doc) => CartProduct.fromDocuments(doc)).toList();

    notifyListeners();
  }

}