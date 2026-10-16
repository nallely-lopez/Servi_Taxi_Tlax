import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/usuario_model.dart';

class LectorUsuarios {
  static Future<List<Usuario>> cargarUsuarios() async {
    final String respuesta = await rootBundle.loadString(
      'assets/data/usuarios.json',
    );
    final List<dynamic> datos = jsonDecode(respuesta) as List<dynamic>;
    return datos
        .map((item) => Usuario.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
