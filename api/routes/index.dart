import 'package:dart_frog/dart_frog.dart';

/// Raíz de la API: confirma que el servidor de ServiTlax está encendido.
Response onRequest(RequestContext context) {
  return Response(body: 'ServiTlax API\n');
}
