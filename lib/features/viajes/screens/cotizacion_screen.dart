import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/widgets/widgets.dart';
import '../../login/login.dart';
import '../models/cotizacion_model.dart';
import '../repositories/viajes_repository.dart';
import '../widgets/desglose_costo_widget.dart';

/// Resumen del precio antes de confirmar. "Confirmar viaje" crea el viaje pendiente.
class CotizacionScreen extends StatelessWidget {
  final Cotizacion cotizacion;

  const CotizacionScreen({super.key, required this.cotizacion});

  void _confirmar(BuildContext context) {
    final pasajero = SesionRepository.instancia.usuarioActual.value;
    if (pasajero == null) return; // No debería pasar: siempre hay sesión aquí.
    final viaje = ViajesRepository.instancia.crear(cotizacion, pasajero);
    // pushReplacementNamed: Confirmación reemplaza a Cotización en la pila,
    // así "atrás" desde Confirmación no regresa a cotizar el mismo viaje.
    Navigator.pushReplacementNamed(context, Rutas.confirmacion, arguments: viaje);
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final servicio = cotizacion.servicio;

    Widget chip(IconData icono, String texto) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: colores.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icono, size: 14),
              const SizedBox(width: 4),
              Text(texto, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
        );

    return Scaffold(
      appBar: const ServiAppBar(titulo: 'Cotización', mostrarAtras: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          Tarjeta(
            child: Row(
              children: [
                IconoServicio(servicio: servicio.nombre, tamano: 64),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(servicio.nombre, style: tema.textTheme.titleMedium?.copyWith(fontSize: 20)),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          chip(Icons.people_outline_rounded, '${servicio.capacidad}'),
                          chip(Icons.straighten_rounded, Formatos.km(cotizacion.ruta.distanciaKm)),
                          chip(Icons.schedule_rounded, Formatos.minutos(cotizacion.ruta.minutos)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text('Recorrido', style: tema.textTheme.titleMedium),
          const SizedBox(height: 10),
          Tarjeta(
            child: RutaOrigenDestino(
              origen: cotizacion.origen.nombre,
              destino: cotizacion.destino.nombre,
            ),
          ),
          const SizedBox(height: 22),
          Text('Desglose del costo', style: tema.textTheme.titleMedium),
          const SizedBox(height: 10),
          DesgloseCosto(cotizacion: cotizacion),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BotonPrincipal(texto: 'Confirmar viaje', onPressed: () => _confirmar(context)),
              const SizedBox(height: 10),
              BotonPrincipal(
                texto: 'Cambiar recorrido',
                tipo: TipoBoton.secundario,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
