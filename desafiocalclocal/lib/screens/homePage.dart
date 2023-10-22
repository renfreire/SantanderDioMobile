import 'package:desafiocalc/database/SharedLocal.dart';
import 'package:desafiocalc/models/dadosimc.dart';
import 'package:desafiocalc/screens/configPage.dart';
import 'package:desafiocalc/services/conexaoDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.nome}) : super(key: key);
  final String nome;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  gravarDadosBD(DadosIMC dadosIMC) async {
    ConexaoDb().inicializarBD();
  }

  calcularIMC(double altura, double peso) async {
    var resultado = peso / altura;
    var descricaoIMC = '';

    switch (resultado) {
      case < 16:
        descricaoIMC = 'Magreza grave';
        break;
      case < 17:
        descricaoIMC = 'Magreza moderada';
        break;
      case < 18.5:
        descricaoIMC = 'Magreza leve';
        break;
      case < 25:
        descricaoIMC = 'Saudavel';
        break;
      case < 30:
        descricaoIMC = 'Sobrepeso';
        break;
      case < 35:
        descricaoIMC = 'Obesidade Grau I';
        break;
      case < 40:
        descricaoIMC = 'Obesidade Grau II (severa)';
        break;
      case >= 40:
        descricaoIMC = 'Obesidade Grau III (mórbida)';
        break;
    }

    //await gravarDadosBD(dadosUsuario);

    listaExibicao.add(DadosIMC(
        usuario: widget.nome,
        horarioCalculo: DateTime.now(),
        peso: peso,
        altura: altura,
        resultado: resultado.round(),
        descricao: descricaoIMC));

    gravaAltura(altura);

    return;
  }

  Future<void> gravaAltura(double altura) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('alturaUsuario', altura);
  }

  carregaAltura() async {
    final prefs = await SharedPreferences.getInstance();
    var altura = prefs.getDouble('alturaUsuario') ?? 0.0;
    if (altura != 0.0) {
      alturaController.text = altura.toString();
      alturaInformada = altura;
    } else {
      alturaController.text = '';
    }
  }

  double pesoInformado = 0.0;
  double alturaInformada = 0.0;
  bool mostraResultado = false;
  List listaExibicao = [];
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    carregaAltura();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amberAccent[400],
        appBar: AppBar(
          backgroundColor: Colors.amberAccent[400],
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfigPage()));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return mostraResultado == false
                ? SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              child: Image.asset('assets/img/logoimccalc.png'),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Bem Vindo ${widget.nome}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: alturaController,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.height,
                                          color: Color.fromARGB(
                                              137, 163, 163, 159),
                                        ),
                                        hintText: 'Informe sua altura'),
                                    onChanged: (value) =>
                                        alturaInformada = double.parse(value),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: pesoController,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.balance,
                                          color: Color.fromARGB(
                                              137, 163, 163, 159),
                                        ),
                                        hintText: 'Informe seu peso'),
                                    onChanged: (value) =>
                                        pesoInformado = double.parse(value),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                      255, 23, 23, 24), // Background color
                                  foregroundColor: Colors
                                      .white, // Text Color (Foreground color)
                                ),
                                onPressed: () {
                                  setState(() {
                                    mostraResultado = !mostraResultado;
                                    calcularIMC(alturaInformada, pesoInformado);
                                  });
                                },
                                child: const Text(
                                  "Calcular IMC",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        SizedBox(
                          child: Image.asset('assets/img/logoimccalc.png'),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bem Vindo ${widget.nome}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: listaExibicao.length,
                            itemBuilder: (_, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 10,
                                color: listaExibicao[index].resultado < 25
                                    ? Colors.green[500]
                                    : listaExibicao[index].resultado < 35
                                        ? Colors.amber[900]
                                        : Colors.red[700],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'IMC Calculado : ${listaExibicao[index].resultado.toString()}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Diagnóstico: ${listaExibicao[index].descricao.toString()}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Realizado por ${listaExibicao[index].usuario.toString()} em ${listaExibicao[index].horarioCalculo.toString()} ',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 8, 110, 5), // Background color
                            foregroundColor:
                                Colors.white, // Text Color (Foreground color)
                          ),
                          onPressed: () {
                            setState(() {
                              mostraResultado = !mostraResultado;
                              pesoController.text = '';
                            });
                          },
                          child: const Text(
                            "Novo Calculo",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
