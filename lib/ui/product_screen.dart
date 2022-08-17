import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {

  final ProductData data;

  ProductScreen(this.data, {Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState(data);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData data;

  _ProductScreenState(this.data);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
