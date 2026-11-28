import 'package:dotenv/dotenv.dart';
import 'package:mysql_dart/mysql_dart.dart';

/// Variables de api/.env (y las del sistema, si existen).
final _env = DotEnv(includePlatformEnvironment: true)..load();

/// Pool de conexiones a la base servitlax.
///
/// Mantiene unas pocas conexiones abiertas y presta una a cada petición,
/// en lugar de abrir una conexión nueva cada vez. Se crea la primera vez
/// que un endpoint lo usa.
final poolBd = MySQLConnectionPool(
  host: _env['DB_HOST'] ?? 'localhost',
  port: int.parse(_env['DB_PORT'] ?? '3306'),
  userName: _env['DB_USER'] ?? 'servitlax_api',
  password: _env['DB_PASSWORD'] ?? '',
  databaseName: _env['DB_NAME'] ?? 'servitlax',
  maxConnections: 5,
  // utf8mb4 guarda bien acentos y ñ (López, Sánchez).
  collation: 'utf8mb4_general_ci',
  // MySQL local usa un certificado generado por él mismo: la conexión va
  // cifrada, pero sin verificar el certificado (mysql_dart 4.0+).
  verifyServerCertificate: false,
);
