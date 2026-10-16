class ServicioTransporte {
  final int id;
  final String nombre;
  final String descripcion;
  final String imagen;
  final int capacidad;
  final double tarifaBase;
  final double precioKm;
  final List<String> caracteristicas;

  ServicioTransporte({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.capacidad,
    required this.tarifaBase,
    required this.precioKm,
    required this.caracteristicas,
  });

  factory ServicioTransporte.fromJson(Map<String, dynamic> json) {
    return ServicioTransporte(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      imagen: json['imagen'] as String,
      capacidad: json['capacidad'] as int,
      tarifaBase: (json['tarifaBase'] as num).toDouble(),
      precioKm: (json['precioKm'] as num).toDouble(),
      caracteristicas: List<String>.from(json['caracteristicas'] as List),
    );
  }
}
