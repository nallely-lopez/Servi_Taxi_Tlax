import 'dart:io';

import 'package:api/consulta_catalogo.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_dart/mysql_dart.dart';

/// GET /servicios/[id]: un servicio con sus características.
Future<Response> onRequest(RequestContext context, String id) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  final numero = int.tryParse(id);
  if (numero == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'error': 'El id del servicio debe ser un número'},
    );
  }
  final bd = context.read<MySQLConnectionPool>();
  final servicios = await consultarServicios(bd, id: numero);
  if (servicios.isEmpty) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: {'error': 'Servicio no encontrado'},
    );
  }
  return Response.json(body: servicios.first);
}
