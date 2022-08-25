import 'package:flutter/material.dart';

import '../ui/login_screen.dart';

class CustomMensagem extends StatelessWidget {

  String? textMensagem;
  int idIcon=0;

  CustomMensagem(this.textMensagem, this.idIcon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if(idIcon==0) Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor)
          else
          if(idIcon==1) Icon(Icons.view_list, size: 80.0, color: Theme.of(context).primaryColor),
          SizedBox(height: 16.0,),
          Text(textMensagem!,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0,),
          RaisedButton(
              child: Text("Entrar", style: TextStyle(fontSize: 18.0,)),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
          )
        ],
      ),
    );
  }

}