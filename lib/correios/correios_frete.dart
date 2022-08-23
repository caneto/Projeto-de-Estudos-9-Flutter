import 'package:flutter/material.dart';

class Correios {
  late String codigo;
  late String valor;
  late String prazo;
  late String entregaDomiciliar;

  String altura = "5";
  String largura = "20";
  String comprimento = "20";

  Correios.fromJson(Map<String, dynamic> json) {
    codigo = json["Codigo"]["\$t"];
    valor = json["Valor"]["\$t"];
    prazo = json["PrazoEntrega"]["\$t"];
    entregaDomiciliar = json["EntregaDomiciliar"]["\$t"];
  }

  Map<String, dynamic> toJson() {
    return {
      'Codigo': codigo,
      'Valor': valor,
      'PrazoEntrega': prazo,
      'EntregaDomiciliar': entregaDomiciliar,
    };
  }
}
