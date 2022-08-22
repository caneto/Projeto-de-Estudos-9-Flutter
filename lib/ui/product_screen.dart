import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/card_product.dart';
import 'package:lojavirtual/datas/product_data.dart';
import 'package:lojavirtual/models/card_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/ui/card_screen.dart';
import 'package:lojavirtual/ui/login_screen.dart';

class ProductScreen extends StatefulWidget {

  final ProductData data;

  ProductScreen(this.data, {Key? key}) : super(key: key);

  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  State<ProductScreen> createState() => _ProductScreenState(data);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData data;

  String size="";

  int _current = 0;

  final CarouselController _carouselController = CarouselController();

  _ProductScreenState(this.data);

  @override
  Widget build(BuildContext context) {

    final Color primeryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title!),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 1.0,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: data.images?.map((e) {
              return Image.network(e, fit: BoxFit.cover);
            }).toList(),
          ),
         ),
         Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: data.images!.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  data.title!,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${data.price!.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primeryColor
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: data.sizes!.map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              color: s == size ? primeryColor : Colors.grey.shade500,
                              width: 3.0
                            ),
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: size != "" ?
                    () {
                      if(UserModel.of(context).isLoggedIn()) {
                        CardProduct cardProduct = CardProduct();
                        cardProduct.size = size;
                        cardProduct.quantity = 1;
                        cardProduct.pid = data.id;
                        cardProduct.category = data.category;

                        CardModel.of(context).addCardItem(cardProduct);

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>CardScreen())
                        );

                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar ao Carrinho" : "Entre para Comprar!",
                        style: TextStyle(
                          fontSize: 18.0
                        ),
                    ),
                    color: primeryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Descrição",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  data.discription!,
                  style: TextStyle(
                      fontSize: 16.0,
                  ),
                ),
              ],
            ),
          )
       ],
      ),
    );
  }
}
