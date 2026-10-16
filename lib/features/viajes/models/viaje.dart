import '../../servicios/models/servicio_transporte_model.dart';
import 'lugar.dart';
import 'ruta.dart';

class Viaje {
  final ServicioTransporte servicio;
  final Lugar origen;
  final Lugar destino;
  final Ruta ruta;
  final double costoEstimado;

  Viaje({
    required this.servicio,
    required this.origen,
    required this.destino,
    required this.ruta,
    required this.costoEstimado,
  });

  // Método de cálculo oficial: Tarifa base + (Distancia * Precio por Km)
  static double calcularCosto({
    required ServicioTransporte servicio,
    required double distanciaKm,
  }) {
    return servicio.tarifaBase + (distanciaKm * servicio.precioKm);
  }
}