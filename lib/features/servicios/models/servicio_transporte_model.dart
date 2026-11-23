/// Un tipo de transporte: Mototaxi, Moto Rápido o Taxi Rápido.
class ServicioTransporte {
  final int id;
  final String nombre;
  final String descripcion;
  final String imagen;
  final int capacidad;
  final double tarifaBase;
  final double precioKm;
  final List<String> caracteristicas;

  const ServicioTransporte({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.capacidad,
    required this.tarifaBase,
    required this.precioKm,
    required this.caracteristicas,
  });

  /// Zona de cobertura (por ahora igual para todos los servicios).
  String get zona => 'Tlaxiaco y alrededores';

  factory ServicioTransporte.fromJson(Map<String, dynamic> json) {
    return ServicioTransporte(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      imagen: json['imagen'] as String,
      capacidad: json['capacidad'] as int,
      // "as num" acepta 10 y 10.0; toDouble() lo deja siempre como decimal.
      tarifaBase: (json['tarifaBase'] as num).toDouble(),
      precioKm: (json['precioKm'] as num).toDouble(),
      caracteristicas: List<String>.from(json['caracteristicas'] as List),
    );
  }
}
