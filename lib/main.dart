import 'package:flutter/material.dart';

/// VERSIÓN TEMPORAL (Paso 21). Solo comprueba que el proyecto compila con la
/// nueva estructura. En el Paso 22 se agrega el tema y en el 24 la navegación.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ServiTlax',
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('ServiTlax: estructura lista'))),
    );
  }
}
