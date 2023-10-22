import 'package:desafiocalc/database/SharedLocal.dart';
import 'package:desafiocalc/screens/HomePage.dart';
import 'package:desafiocalc/screens/SplashPage.dart';
import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  void initState() {
    super.initState();
    carregaDadosNome();
  }

  carregaDadosNome() async {
    var pref = SharedLocal();
    nomeUsuario = await pref.leNome();
  }

  var nomeUsuario = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent[400],
      appBar: AppBar(
        backgroundColor: Colors.amberAccent[400],
        title: const Text('Configurações'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: 70,
        child: ElevatedButton(
          child: const Text(
            "Limpar dados Gravados",
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
          onPressed: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Limpar Dados'),
                  content: const Text(
                      'Tem certeza que deseja excluir os dados gravados ?'),
                  actions: [
                    TextButton(
                      child: const Text('Não'),
                      onPressed: () {
                        //Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              nome: nomeUsuario,
                            ),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                    TextButton(
                      child: const Text('Sim'),
                      onPressed: () {
                        SharedLocal().limpaDados();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
