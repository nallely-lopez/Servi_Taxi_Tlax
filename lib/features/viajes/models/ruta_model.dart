/// Distancia y tiempo entre dos lugares.
class Ruta {
  final int id;
  final int origenId;
  final int destinoId;
  final double distanciaKm;
  final int minutos;

  const Ruta({
    required this.id,
    required this.origenId,
    required this.destinoId,
    required this.distanciaKm,
    required this.minutos,
  });

  factory Ruta.fromJson(Map<String, dynamic> json) {
    return Ruta(
      id: json['id'] as int,
      origenId: json['origenId'] as int,
      destinoId: json['destinoId'] as int,
      distanciaKm: (json['distanciaKm'] as num).toDouble(),
      minutos: json['minutos'] as int,
    );
  }
}
