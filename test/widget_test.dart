import 'package:flutter_test/flutter_test.dart';
import 'package:servi_taxi_tlax/core/core.dart';
import 'package:servi_taxi_tlax/features/viajes/viajes.dart';

/// Pruebas básicas. Se ejecutan con: flutter test
void main() {
  // Prueba 1: el viaje cambia de estado y conserva sus datos.
  test('Un viaje aceptado guarda el conductor y cancelarlo lo quita', () {
    final viaje = Viaje(
      id: 1,
      pasajeroId: 1,
      pasajeroNombre: 'Prueba',
      conductorId: null,
      conductorNombre: null,
      servicioId: 1,
      servicioNombre: 'Mototaxi',
      origen: 'Tlaxiaco',
      destino: 'Magdalena',
      distanciaKm: 3.5,
      minutos: 11,
      total: 27.5,
      estado: EstadoViaje.pendiente,
      fecha: DateTime(2026, 11, 22),
    );

    final aceptado = viaje.conEstado(
      EstadoViaje.aceptado,
      conductorId: 2,
      conductorNombre: 'Abelardo',
    );
    expect(aceptado.estado, EstadoViaje.aceptado);
    expect(aceptado.conductorId, 2);
    expect(aceptado.folio, 'VT-1');

    final cancelado = aceptado.conEstado(EstadoViaje.pendiente);
    expect(cancelado.conductorId, isNull);
    expect(cancelado.total, 27.5);
  });
}
