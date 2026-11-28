import 'dart:io';

import 'package:api/convertir.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_dart/mysql_dart.dart';

/// GET /rutas: distancia y tiempo entre pares de lugares.
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  final bd = context.read<MySQLConnectionPool>();
  final resultado = await bd.execute(
    'SELECT id, origen_id, destino_id, km, minutos FROM rutas ORDER BY id',
  );
  final rutas = [
    for (final fila in resultado.rows)
      () {
        final datos = fila.assoc();
        return <String, Object?>{
          'id': aEntero(datos['id']),
          'origenId': aEntero(datos['origen_id']),
          'destinoId': aEntero(datos['destino_id']),
          'distanciaKm': aDecimal(datos['km']),
          'minutos': aEntero(datos['minutos']),
        };
      }(),
  ];
  return Response.json(body: rutas);
}
