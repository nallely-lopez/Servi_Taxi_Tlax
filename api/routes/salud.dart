import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_dart/mysql_dart.dart';

/// GET /salud: comprueba que la API puede consultar MySQL.
Future<Response> onRequest(RequestContext context) async {
  final bd = context.read<MySQLConnectionPool>();
  try {
    final resultado = await bd.execute(
      'SELECT COUNT(*) AS usuarios FROM usuarios',
    );
    final usuarios = resultado.rows.first.typedColByName<int>('usuarios');
    return Response.json(
      body: {'ok': true, 'bd': 'conectada', 'usuarios': usuarios},
    );
  } on Exception catch (error) {
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: {'ok': false, 'bd': 'sin conexion', 'error': '$error'},
    );
  }
}
