import 'package:desafioimc2/desafioimc2.dart' as desafioimc2;
import 'package:desafioimc2/pessoa_model.dart';

var resultado = '';

void main() {
  try {
    String nome = desafioimc2.lerDados('Digite Seu Nome');
    if (nome.length == 0) {
      throw Exception('O nome não foi informado. Tente novamente');
    }

    String peso = desafioimc2.lerDados('Digite Seu Peso Atual');
    if (double.tryParse(peso) == null) {
      throw Exception('Peso Inválido. Tente novamente');
    }

    String altura = desafioimc2.lerDados('Digite Sua Altura Atual');

    if (double.tryParse(altura) == null) {
      throw Exception('Altura inválida. Tente novamente');
    }

    Pessoa pessoa = Pessoa(
        peso: double.tryParse(peso),
        altura: double.tryParse(altura),
        nome: nome);

    desafioimc2.calculaIMC(pessoa);
  } catch (e) {
    print(e);
  }
}
