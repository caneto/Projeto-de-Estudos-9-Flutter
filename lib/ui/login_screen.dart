import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/ui/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=>SignupScreen())
              );
            },
            child: Text("Criar Conta",
            style: TextStyle(fontSize: 16.0),),
            textColor: Colors.white,
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if(model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'E-mail'
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text!.isEmpty || !text.contains("@"))
                      return "E-mail invalido!";
                  },
                ),
                SizedBox(height: 16.0,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Senha'
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text!.isEmpty || text.length < 6)
                      return "Senha invalida!";
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("Esqueci minha senha",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 16.0),),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                      child: Text("Entrar",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                        }
                        model.signIn();
                      }
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
