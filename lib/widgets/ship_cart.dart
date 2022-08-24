import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lojavirtual/correios/correios_frete.dart';
import 'package:lojavirtual/correios/via_cep_service.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cálcular Frete",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.location_on),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite seu CEP"
              ),
              initialValue: "",
              onFieldSubmitted: (cepDigitado) async {

                String _result;

                final resultCep = await ViaCepService.fetchCep(cep: cepDigitado);
                print(resultCep.localidade); // Exibindo somente a localidade no terminal
                _result = resultCep.toJson();

                Xml2Json xml2json = new Xml2Json(); // class parse XML to JSON

                try {
                  var url = Uri.parse(
                      "http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx?nCdEmpresa=&sDsSenha=&sCepOrigem=21360230&sCepDestino=$cepDigitado&nVlPeso=1&nCdFormato=1&nVlComprimento=20&nVlAltura=20&nVlLargura=20&sCdMaoPropria=n&nVlValorDeclarado=0&sCdAvisoRecebimento=n&nCdServico=04510&nVlDiametro=0&StrRetorno=xml&nIndicaCalculo=3"
                  );

                  http.Response reponse = await http.get(url);

                  print("GET DO XML");
                  print(reponse.body);

                  if (reponse.statusCode == 200) {
                    xml2json.parse(reponse.body);

                    var resultMap = xml2json.toGData();

                    Correios correios = Correios.fromJson(
                        json.decode(resultMap)["Servicos"]["cServico"]);

                    CartModel.of(context).setShip(int.parse(correios.prazo), double.parse(correios.valor.replaceAll(",", ".")));

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text(
                            "R\$ ${correios.valor} reais \nPrazo da entrega: ${correios.prazo} dias"),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Erro de conexão: ${reponse.statusCode}"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                } catch (erro) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(erro.toString()),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
