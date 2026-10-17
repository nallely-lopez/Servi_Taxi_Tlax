import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/lugar.dart';

class LectorLugaresUtils {
  static Future<List<Lugar>> cargarLugares() async {
    final respuesta = await rootBundle.loadString('assets/data/lugares.json');
    final datos = jsonDecode(respuesta) as List<dynamic>;
    return datos
        .map((item) => Lugar.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
