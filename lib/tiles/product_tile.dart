import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/product_data.dart';
import 'package:lojavirtual/ui/product_screen.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData data;

  ProductTile(this.type, this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductScreen(data))
        );
      },
      child: Card(
        child: type == "grid" ?
           Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               AspectRatio(
                 aspectRatio: 0.8,
                 child: Image.network(
                  data.images![0],
                  fit: BoxFit.cover,
                ),
               ),
               Expanded(
                 child: Container(
                   padding: EdgeInsets.all(0.0),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.only(left: 2.0, bottom: 1.0),
                         child: Text(data.title!,
                           style: TextStyle(
                             fontWeight: FontWeight.w500
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 2.0),
                         child: Text(
                            "R\$ ${data.price!.toStringAsFixed(2)}",
                           style: TextStyle(
                             color: Theme.of(context).primaryColor,
                             fontSize: 17.0,
                             fontWeight: FontWeight.bold
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               )
             ],
           )
        : Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                data.images![0],
                fit: BoxFit.cover,
                height: 250.0,
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 1.0),
                      child: Text(data.title!,
                        style: TextStyle(
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Text(
                        "R\$ ${data.price!.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
