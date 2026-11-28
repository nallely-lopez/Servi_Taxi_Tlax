import 'dart:io';

import 'package:api/consulta_catalogo.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_dart/mysql_dart.dart';

/// GET /servicios: catálogo con los 3 servicios de transporte.
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  final bd = context.read<MySQLConnectionPool>();
  final servicios = await consultarServicios(bd);
  return Response.json(body: servicios);
}
