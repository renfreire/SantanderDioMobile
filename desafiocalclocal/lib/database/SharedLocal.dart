import 'package:shared_preferences/shared_preferences.dart';

class SharedLocal {
  Future<void> gravaNome(String nome) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nomeUsuario', nome);
  }

  leNome() async {
    final prefs = await SharedPreferences.getInstance();
    String nome = prefs.getString('nomeUsuario') ?? '';
    return nome;
  }

  Future<void> gravaAltura(double altura) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('alturaUsuario', altura);
  }

  leAltura() async {
    final prefs = await SharedPreferences.getInstance();
    double altura = prefs.getDouble('alturaUsuario') ?? 0.0;
    return altura;
  }

  void limpaDados() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
