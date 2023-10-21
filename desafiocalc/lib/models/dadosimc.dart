// ignore_for_file: public_member_api_docs, sort_constructors_first
class DadosIMC {
  double peso;
  double altura;
  int? resultado;
  String? descricao;

  DadosIMC({
    required this.peso,
    required this.altura,
    required this.resultado,
    required this.descricao,
  });

  @override
  String toString() {
    return 'DadosIMC(peso: $peso, altura: $altura, resultado: $resultado, descricao: $descricao)';
  }
}
