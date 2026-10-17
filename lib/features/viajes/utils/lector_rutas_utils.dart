import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/ruta.dart';
 
class LectorRutas {
  static Future<List<Ruta>> cargarRutas() async {
    final String respuesta = await rootBundle.loadString('assets/data/rutas.json');
    final List<dynamic> datos = jsonDecode(respuesta) as List<dynamic>;
    return datos.map((item) => Ruta.fromJson(item as Map<String, dynamic>)).toList();
  }
}