import '../../../core/core.dart';

/// Una persona que usa la app: pasajero o conductor.
class Usuario {
  final int id;
  final String nombreCompleto;
  final String nombreCorto; // Para el saludo: "¡Hola, Nallely!"
  final String usuario; // Sin @: "nallely"
  final String correo;
  final String claveAcceso; // Solo en la versión local. La API usará hash.
  final Rol rol;
  final double calificacion; // Promedio de estrellas (4.9). Fijo mientras no haya pantalla para calificar.

  const Usuario({
    required this.id,
    required this.nombreCompleto,
    required this.nombreCorto,
    required this.usuario,
    required this.correo,
    required this.claveAcceso,
    required this.rol,
    this.calificacion = 5.0,
  });

  /// Iniciales para el avatar: "Lizeth Nallely López García" → "LL".
  String get iniciales {
    final partes = nombreCompleto.trim().split(RegExp(r'\s+'));
    final primera = partes.first[0];
    final segunda = partes.length > 1 ? partes[1][0] : '';
    return (primera + segunda).toUpperCase();
  }

  /// Convierte un mapa del JSON en un objeto Usuario.
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      nombreCompleto: json['nombreCompleto'] as String,
      nombreCorto: json['nombreCorto'] as String,
      usuario: json['usuario'] as String,
      correo: json['correo'] as String,
      claveAcceso: json['claveAcceso'] as String,
      // byName busca el valor del enum por su texto: 'conductor' → Rol.conductor
      rol: Rol.values.byName(json['rol'] as String),
      // ?? 5.0: si el JSON no trae calificación, se usa 5.0.
      calificacion: (json['calificacion'] as num?)?.toDouble() ?? 5.0,
    );
  }
}
