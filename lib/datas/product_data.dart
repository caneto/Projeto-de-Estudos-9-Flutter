import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  String? category;
  String? id;

  String? title;
  String? discription;

  double? price;

  List? images;
  List? sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot.get('title');
    discription = snapshot.get('discription');
    price = snapshot.get('price') + 0.0;
    images = snapshot.get('images');
    sizes  = snapshot.get('sizes');
  }

}