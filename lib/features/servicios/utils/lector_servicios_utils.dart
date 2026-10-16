import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/servicio_transporte_model.dart';

class LectorServicios {
  static Future<List<ServicioTransporte>> cargarServicios() async {
    final String respuesta = await rootBundle.loadString(
      'assets/data/servicios.json',
    );
    final List<dynamic> datos = jsonDecode(respuesta) as List<dynamic>;
    return datos
        .map(
          (item) => ServicioTransporte.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }
}
