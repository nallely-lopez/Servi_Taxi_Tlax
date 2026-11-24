import 'package:flutter/material.dart';

import 'core/core.dart';
import 'core/navigation/app_router.dart';

void main() {
  runApp(const MyApp());
}

/// Raíz de la app. Se llama MyApp porque test/widget_test.dart la usa con ese nombre.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Escucha temaActual: cuando el usuario cambia la Apariencia en Perfil,
    // este builder se vuelve a ejecutar y MaterialApp aplica el nuevo modo.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: temaActual,
      builder: (context, modo, _) => MaterialApp(
        title: 'ServiTlax',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.claro,
        darkTheme: AppTheme.oscuro,
        themeMode: modo,
        initialRoute: Rutas.splash,
        onGenerateRoute: AppRouter.generarRuta,
      ),
    );
  }
}
