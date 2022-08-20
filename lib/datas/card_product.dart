
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/product_data.dart';

class CardProduct {

  String? cid;
  String? category;
  String? pid;

  int? quantity;
  String? size;

  ProductData? productData;

  CardProduct.fromDocuments(DocumentSnapshot documents) {
    cid = documents.id;
    category = documents.get("category");
    pid = documents.get("pid");
    quantity = documents.get("quantity");
    size = documents.get("size");
  }
}