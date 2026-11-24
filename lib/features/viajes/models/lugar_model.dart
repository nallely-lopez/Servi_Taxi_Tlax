/// Un punto de origen o destino: "Magdalena", "Hospital San Pedro"…
class Lugar {
  final int id;
  final String nombre;
  final String descripcion; // "Barrio de Magdalena", "Urgencias 24 h"

  const Lugar({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory Lugar.fromJson(Map<String, dynamic> json) {
    return Lugar(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
    );
  }
}
