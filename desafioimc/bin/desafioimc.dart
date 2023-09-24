import 'dart:convert';
import 'dart:io';

import 'package:desafioimc/pessoa_model.dart';

lerDados(mensagem) {
  print(mensagem);
  return stdin.readLineSync(encoding: utf8);
}

double calculaIMC(peso, altura) {
  double pesodouble = peso;
  double alturadouble = altura;
  double result = pesodouble / (alturadouble * alturadouble);
  return result;
}

void main() {
  try {
    var nome = lerDados('Digite Seu Nome');
    var peso = lerDados('Digite Seu Peso Atual');
    var altura = lerDados('Digite Sua Altura Atual');
    var resultado = '';

    Pessoa pessoa = Pessoa();

    if (nome != null) {
      pessoa.nome = nome;
    }

    if (altura != null) {
      pessoa.altura = double.tryParse(altura);
    }

    if (peso != null) {
      pessoa.peso = double.tryParse(peso);
    }

    var resultadoIMC = calculaIMC(peso, altura);

    switch (resultadoIMC) {
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

    print('$nome o seu IMC é $resultadoIMC');
    print(resultado);
  } catch (e) {
    print(e);
  }
}
