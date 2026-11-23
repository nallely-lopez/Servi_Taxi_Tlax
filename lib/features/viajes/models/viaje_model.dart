import '../../../core/core.dart';

/// Un viaje solicitado. Guarda una COPIA de los nombres, la distancia y el total:
/// si mañana cambia una tarifa, los viajes ya hechos no cambian.
class Viaje {
  final int id;
  final int pasajeroId;
  final String pasajeroNombre;
  final int? conductorId; // null mientras el viaje está pendiente
  final String? conductorNombre;
  final int servicioId;
  final String servicioNombre;
  final String origen;
  final String destino;
  final double distanciaKm;
  final int minutos;
  final double total;
  final EstadoViaje estado;
  final DateTime fecha;

  const Viaje({
    required this.id,
    required this.pasajeroId,
    required this.pasajeroNombre,
    required this.conductorId,
    required this.conductorNombre,
    required this.servicioId,
    required this.servicioNombre,
    required this.origen,
    required this.destino,
    required this.distanciaKm,
    required this.minutos,
    required this.total,
    required this.estado,
    required this.fecha,
  });

  /// Folio que se muestra: 1042 → "VT-1042".
  String get folio => 'VT-$id';

  factory Viaje.fromJson(Map<String, dynamic> json) {
    return Viaje(
      id: json['id'] as int,
      pasajeroId: json['pasajeroId'] as int,
      pasajeroNombre: json['pasajeroNombre'] as String,
      conductorId: json['conductorId'] as int?,
      conductorNombre: json['conductorNombre'] as String?,
      servicioId: json['servicioId'] as int,
      servicioNombre: json['servicioNombre'] as String,
      origen: json['origen'] as String,
      destino: json['destino'] as String,
      distanciaKm: (json['distanciaKm'] as num).toDouble(),
      minutos: json['minutos'] as int,
      total: (json['total'] as num).toDouble(),
      estado: EstadoViaje.values.byName(json['estado'] as String),
      fecha: DateTime.parse(json['fecha'] as String),
    );
  }

  /// Crea una copia cambiando solo el estado y el conductor.
  /// Los objetos Viaje no se modifican (son inmutables): se reemplazan por copias.
  Viaje conEstado(
    EstadoViaje nuevoEstado, {
    int? conductorId,
    String? conductorNombre,
  }) {
    return Viaje(
      id: id,
      pasajeroId: pasajeroId,
      pasajeroNombre: pasajeroNombre,
      conductorId: conductorId,
      conductorNombre: conductorNombre,
      servicioId: servicioId,
      servicioNombre: servicioNombre,
      origen: origen,
      destino: destino,
      distanciaKm: distanciaKm,
      minutos: minutos,
      total: total,
      estado: nuevoEstado,
      fecha: fecha,
    );
  }
}
