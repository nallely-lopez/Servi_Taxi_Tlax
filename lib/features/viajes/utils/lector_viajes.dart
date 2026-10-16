import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/lugar.dart';
import '../models/ruta.dart';

class LectorViajes {
  static Future<List<Lugar>> cargarLugares() async {
    final String respuesta = await rootBundle.loadString('assets/data/lugares.json');
    final List<dynamic> datos = jsonDecode(respuesta) as List<dynamic>;
    return datos.map((item) => Lugar.fromJson(item as Map<String, dynamic>)).toList();
  }

  static Future<List<Ruta>> cargarRutas() async {
    final String respuesta = await rootBundle.loadString('assets/data/rutas.json');
    final List<dynamic> datos = jsonDecode(respuesta) as List<dynamic>;
    return datos.map((item) => Ruta.fromJson(item as Map<String, dynamic>)).toList();
  }
}