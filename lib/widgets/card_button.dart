import 'package:flutter/material.dart';
import 'package:lojavirtual/ui/card_screen.dart';

class CardButton extends StatelessWidget {
  const CardButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CardScreen())
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
