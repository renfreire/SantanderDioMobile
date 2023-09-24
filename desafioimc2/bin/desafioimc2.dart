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
      throw Exception('Informe um peso válido');
    }

    String altura = desafioimc2.lerDados('Digite Sua Altura Atual');

    if (double.tryParse(altura) == null) {
      throw Exception('Informe uma altura válida');
    }

    Pessoa pessoa = Pessoa(
        peso: double.tryParse(peso) != null ? double.tryParse(peso) : 0,
        altura: double.tryParse(altura) != null ? double.tryParse(altura) : 0,
        nome: nome);

    desafioimc2.calculaIMC(pessoa);
  } catch (e) {
    print(e);
  }
}
