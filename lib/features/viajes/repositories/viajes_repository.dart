import 'package:flutter/foundation.dart';

import '../../../core/core.dart';
import '../../login/login.dart';
import '../models/cotizacion_model.dart';
import '../models/viaje_model.dart';
import '../services/viajes_service.dart';

/// Lo que usan las pantallas para crear viajes y cambiar su estado.
/// Guarda los viajes en memoria dentro de un ValueNotifier: cuando un viaje
/// cambia, todas las pantallas que lo escuchan se redibujan solas.
/// Así el pasajero ve en "Mis viajes" que el conductor aceptó su viaje.
class ViajesRepository {
  ViajesRepository._();
  static final ViajesRepository instancia = ViajesRepository._();

  final ViajesService _service = ViajesService();
  final ValueNotifier<List<Viaje>> viajes = ValueNotifier([]);

  Future<void> cargar() async {
    if (viajes.value.isNotEmpty) return;
    final lista = await _service.obtenerViajes();
    lista.sort((a, b) => b.fecha.compareTo(a.fecha)); // Más recientes primero
    viajes.value = lista;
  }

  // ---------- Consultas ----------

  List<Viaje> dePasajero(int pasajeroId) =>
      viajes.value.where((v) => v.pasajeroId == pasajeroId).toList();

  List<Viaje> pendientes() =>
      viajes.value.where((v) => v.estado == EstadoViaje.pendiente).toList();

  List<Viaje> aceptadosDe(int conductorId) => viajes.value
      .where(
        (v) => v.conductorId == conductorId && v.estado == EstadoViaje.aceptado,
      )
      .toList();

  List<Viaje> completadosDe(int conductorId) => viajes.value
      .where(
        (v) =>
            v.conductorId == conductorId && v.estado == EstadoViaje.completado,
      )
      .toList();

  Viaje? buscarPorId(int id) {
    for (final v in viajes.value) {
      if (v.id == id) return v;
    }
    return null;
  }

  // ---------- Acciones ----------

  /// Convierte la cotización en un viaje pendiente.
  Viaje crear(Cotizacion cotizacion, Usuario pasajero) {
    final siguienteId = viajes.value.isEmpty
        ? 1001
        : viajes.value.map((v) => v.id).reduce((a, b) => a > b ? a : b) + 1;
    final nuevo = Viaje(
      id: siguienteId,
      pasajeroId: pasajero.id,
      pasajeroNombre: pasajero.nombreCompleto,
      conductorId: null,
      conductorNombre: null,
      servicioId: cotizacion.servicio.id,
      servicioNombre: cotizacion.servicio.nombre,
      origen: cotizacion.origen.nombre,
      destino: cotizacion.destino.nombre,
      distanciaKm: cotizacion.ruta.distanciaKm,
      minutos: cotizacion.ruta.minutos,
      total: cotizacion.total,
      estado: EstadoViaje.pendiente,
      fecha: DateTime.now(),
    );
    viajes.value = [nuevo, ...viajes.value];
    return nuevo;
  }

  /// Solo un viaje pendiente se puede aceptar.
  void aceptar(int viajeId, Usuario conductor) {
    _cambiar(
      viajeId,
      desde: EstadoViaje.pendiente,
      (v) => v.conEstado(
        EstadoViaje.aceptado,
        conductorId: conductor.id,
        conductorNombre: conductor.nombreCompleto,
      ),
    );
  }

  /// Cancelar regresa el viaje a pendiente y le quita el conductor,
  /// para que otro conductor pueda tomarlo.
  void cancelar(int viajeId) {
    _cambiar(
      viajeId,
      desde: EstadoViaje.aceptado,
      (v) => v.conEstado(EstadoViaje.pendiente),
    );
  }

  /// Solo un viaje aceptado se puede finalizar.
  void finalizar(int viajeId) {
    _cambiar(
      viajeId,
      desde: EstadoViaje.aceptado,
      (v) => v.conEstado(
        EstadoViaje.completado,
        conductorId: v.conductorId,
        conductorNombre: v.conductorNombre,
      ),
    );
  }

  /// Reemplaza el viaje por su copia modificada, revisando el estado actual.
  void _cambiar(
    int viajeId,
    Viaje Function(Viaje) cambio, {
    required EstadoViaje desde,
  }) {
    final lista = [...viajes.value];
    final i = lista.indexWhere((v) => v.id == viajeId);
    if (i == -1) throw StateError('El viaje $viajeId no existe.');
    if (lista[i].estado != desde) {
      throw StateError('El viaje ya no está ${desde.etiqueta.toLowerCase()}.');
    }
    lista[i] = cambio(lista[i]);
    viajes.value = lista; // Asignar una lista nueva avisa a los que escuchan.
  }
}
