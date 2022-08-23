
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/product_data.dart';

class CartProduct {

  String? cid;
  String? category;
  String? pid;

  int quantity = 0;
  String? size;

  ProductData? productData;

  CartProduct();

  CartProduct.fromDocuments(DocumentSnapshot documents) {
    cid = documents.id;
    category = documents.get("category");
    pid = documents.get("pid");
    quantity = documents.get("quantity");
    size = documents.get("size");
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": productData?.toResumeMap()
    };
  }

}