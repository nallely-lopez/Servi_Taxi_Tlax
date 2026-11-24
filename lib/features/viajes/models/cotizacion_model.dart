import '../../servicios/servicios.dart';
import 'lugar_model.dart';
import 'ruta_model.dart';

/// Lo que el pasajero eligió antes de confirmar: servicio, origen, destino y ruta.
/// Todavía no es un viaje: se convierte en Viaje al pulsar "Confirmar viaje".
class Cotizacion {
  final ServicioTransporte servicio;
  final Lugar origen;
  final Lugar destino;
  final Ruta ruta;

  const Cotizacion({
    required this.servicio,
    required this.origen,
    required this.destino,
    required this.ruta,
  });

  /// Costo por la distancia: km × precio por km.
  double get costoDistancia => ruta.distanciaKm * servicio.precioKm;

  /// Fórmula oficial: tarifa base + km × precio por km.
  double get total => servicio.tarifaBase + costoDistancia;
}
