import 'package:api/convertir.dart';
import 'package:mysql_dart/mysql_dart.dart';

/// Lee los servicios con sus características y los devuelve con el mismo
/// formato que assets/data/servicios.json de la app.
/// Si se pasa [id], devuelve solo ese servicio (lista vacía si no existe).
Future<List<Map<String, Object?>>> consultarServicios(
  MySQLConnectionPool bd, {
  int? id,
}) async {
  final filtro = id == null ? '' : 'WHERE id = :id';
  final servicios = await bd.execute(
    'SELECT id, nombre, descripcion, imagen, capacidad, tarifa_base, '
    'precio_km FROM servicios $filtro ORDER BY id',
    id == null ? null : {'id': id},
  );
  final caracteristicas = await bd.execute(
    'SELECT servicio_id, texto FROM caracteristicas ORDER BY id',
  );

  final porServicio = <int, List<String>>{};
  for (final fila in caracteristicas.rows) {
    final datos = fila.assoc();
    porServicio
        .putIfAbsent(aEntero(datos['servicio_id']), () => <String>[])
        .add(datos['texto'] ?? '');
  }

  return [
    for (final fila in servicios.rows)
      () {
        final datos = fila.assoc();
        final idServicio = aEntero(datos['id']);
        return <String, Object?>{
          'id': idServicio,
          'nombre': datos['nombre'],
          'descripcion': datos['descripcion'],
          'imagen': datos['imagen'],
          'capacidad': aEntero(datos['capacidad']),
          'tarifaBase': aDecimal(datos['tarifa_base']),
          'precioKm': aDecimal(datos['precio_km']),
          'caracteristicas': porServicio[idServicio] ?? <String>[],
        };
      }(),
  ];
}
