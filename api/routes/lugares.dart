import 'dart:io';

import 'package:api/convertir.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_dart/mysql_dart.dart';

/// GET /lugares: lugares de Tlaxiaco disponibles como origen o destino.
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  final bd = context.read<MySQLConnectionPool>();
  final resultado = await bd.execute(
    'SELECT id, nombre, descripcion FROM lugares ORDER BY id',
  );
  final lugares = [
    for (final fila in resultado.rows)
      () {
        final datos = fila.assoc();
        return <String, Object?>{
          'id': aEntero(datos['id']),
          'nombre': datos['nombre'],
          'descripcion': datos['descripcion'],
        };
      }(),
  ];
  return Response.json(body: lugares);
}
