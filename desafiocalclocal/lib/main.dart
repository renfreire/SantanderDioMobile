import 'package:desafiocalc/screens/HomePage.dart';
import 'package:desafiocalc/screens/splashPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

String nomeUsuario = '';

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuario = prefs.getString('nomeUsuario') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculadora IMC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 149, 146, 155)),
          useMaterial3: true,
        ),
        home: nomeUsuario == ''
            ? const SplashPage()
            : HomePage(nome: nomeUsuario));
  }
}
