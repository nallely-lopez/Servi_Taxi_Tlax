import 'dart:convert';

import 'package:flutter/services.dart';

/// Lee un archivo JSON de assets/data/ y lo devuelve como lista de mapas.
/// Lo usan todos los services mientras no exista la API.
/// Cuando llegue la API, los services dejarán de usarlo y harán peticiones HTTP.
class JsonLocalService {
  JsonLocalService._();

  static Future<List<Map<String, dynamic>>> leerLista(String archivo) async {
    // rootBundle lee archivos declarados en pubspec.yaml (sección assets).
    final texto = await rootBundle.loadString('assets/data/$archivo');
    final datos = jsonDecode(texto) as List<dynamic>;
    return datos.cast<Map<String, dynamic>>();
  }
}
