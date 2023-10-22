import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DadosIMC {
  String usuario;
  DateTime horarioCalculo;
  double peso;
  double altura;
  int? resultado;
  String? descricao;

  DadosIMC({
    required this.usuario,
    required this.horarioCalculo,
    required this.peso,
    required this.altura,
    required this.resultado,
    required this.descricao,
  });

  @override
  String toString() {
    return 'DadosIMC(usuario: $usuario, horarioCalculo: $horarioCalculo, peso: $peso, altura: $altura, resultado: $resultado, descricao: $descricao)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuario': usuario,
      'horarioCalculo': horarioCalculo.millisecondsSinceEpoch,
      'peso': peso,
      'altura': altura,
      'resultado': resultado,
      'descricao': descricao,
    };
  }

  factory DadosIMC.fromMap(Map<String, dynamic> map) {
    return DadosIMC(
      usuario: map['usuario'] as String,
      horarioCalculo:
          DateTime.fromMillisecondsSinceEpoch(map['horarioCalculo'] as int),
      peso: map['peso'] as double,
      altura: map['altura'] as double,
      resultado: map['resultado'] != null ? map['resultado'] as int : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DadosIMC.fromJson(String source) =>
      DadosIMC.fromMap(json.decode(source) as Map<String, dynamic>);
}
