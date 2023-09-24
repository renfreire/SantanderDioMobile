import 'dart:convert';
import 'dart:io';

import 'package:desafioimc2/pessoa_model.dart';

lerDados(mensagem) {
  print(mensagem);
  return stdin.readLineSync(encoding: utf8);
}

calculaIMC(Pessoa pessoa) {
  try {
    String resultado = "";
    double pesodouble = pessoa.peso!;
    double alturadouble = pessoa.altura!;
    double result = pesodouble / (alturadouble * alturadouble);

    switch (result) {
      case < 16:
        resultado = 'Magreza grave';
        break;
      case < 17:
        resultado = 'Magreza moderada';
        break;
      case < 18.5:
        resultado = 'Magreza leve';
        break;
      case < 25:
        resultado = 'Saudavel';
        break;
      case < 30:
        resultado = 'Sobrepeso';
        break;
      case < 35:
        resultado = 'Obesidade Grau I';
        break;
      case < 40:
        resultado = 'Obesidade Grau II (severa)';
        break;
      case >= 40:
        resultado = 'Obesidade Grau III (mórbida)';
        break;
    }

    print(result);
    print('${pessoa.nome} seu IMC é $result - $resultado ');
  } catch (e) {
    print(e);
  }
}
