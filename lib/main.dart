import 'package:flutter/material.dart';

import 'core/core.dart';

/// VERSIÓN TEMPORAL (Paso 22). Ya usa el tema claro y oscuro.
/// En el Paso 24 se reemplaza por la versión final con navegación.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: temaActual,
      builder: (context, modo, _) => MaterialApp(
        title: 'ServiTlax',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.claro,
        darkTheme: AppTheme.oscuro,
        themeMode: modo,
        home: Scaffold(
          body: Center(
            child: Builder(
              builder: (context) => FilledButton(
                onPressed: () {},
                child: const Text('Botón con el tema de ServiTlax'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
