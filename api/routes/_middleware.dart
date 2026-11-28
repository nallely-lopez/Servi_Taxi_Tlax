import 'package:api/bd.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mysql_dart/mysql_dart.dart';

/// Corre antes de cada endpoint: muestra la petición en la terminal y
/// comparte el pool de MySQL con context.read<MySQLConnectionPool>().
Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<MySQLConnectionPool>((_) => poolBd));
}
