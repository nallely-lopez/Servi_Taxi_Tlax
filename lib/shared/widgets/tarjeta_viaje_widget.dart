import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../features/viajes/viajes.dart';
import 'chip_estado_widget.dart';
import 'icono_servicio_widget.dart';
import 'ruta_origen_destino_widget.dart';
import 'tarjeta_widget.dart';

/// Tarjeta de un viaje. La usan Mis viajes, Confirmación, Solicitudes
/// y Viajes aceptados.
///  - mostrarPasajero: el título es el nombre del pasajero (vista del conductor).
///  - mostrarConductor: muestra "Conductor: ..." abajo (vista del pasajero).
///  - pie: widget extra al final (por ejemplo "Ver solicitud >" o botones).
class TarjetaViaje extends StatelessWidget {
  final Viaje viaje;
  final bool mostrarPasajero;
  final bool mostrarConductor;
  final Widget? pie;
  final VoidCallback? onTap;

  const TarjetaViaje({
    super.key,
    required this.viaje,
    this.mostrarPasajero = false,
    this.mostrarConductor = true,
    this.pie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final pequeno = tema.textTheme.bodySmall?.copyWith(fontSize: 13);

    final titulo = mostrarPasajero ? viaje.pasajeroNombre : viaje.servicioNombre;
    final subtitulo = mostrarPasajero
        ? '${viaje.servicioNombre} · ${viaje.folio} · ${Formatos.fechaCorta(viaje.fecha)}'
        : '${viaje.folio} · ${Formatos.fechaCorta(viaje.fecha)}';

    return Tarjeta(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado: ícono, título, folio y estado
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconoServicio(servicio: viaje.servicioNombre, tamano: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titulo, style: tema.textTheme.labelLarge?.copyWith(fontSize: 16)),
                    const SizedBox(height: 2),
                    Text(subtitulo, style: pequeno),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ChipEstado(estado: viaje.estado),
            ],
          ),
          const SizedBox(height: 16),
          RutaOrigenDestino(origen: viaje.origen, destino: viaje.destino),
          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 12),
          // Distancia, tiempo y total
          Row(
            children: [
              Icon(Icons.straighten_rounded, size: 16, color: colores.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(Formatos.km(viaje.distanciaKm), style: pequeno),
              const SizedBox(width: 14),
              Icon(Icons.schedule_rounded, size: 16, color: colores.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(Formatos.minutos(viaje.minutos), style: pequeno),
              const Spacer(),
              Text(
                Formatos.dinero(viaje.total),
                style: tema.textTheme.headlineSmall?.copyWith(fontSize: 22),
              ),
            ],
          ),
          if (mostrarConductor && viaje.conductorNombre != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: colores.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text.rich(
                TextSpan(
                  style: pequeno?.copyWith(color: colores.onSurfaceVariant),
                  children: [
                    const TextSpan(text: 'Conductor: '),
                    TextSpan(
                      text: viaje.conductorNombre,
                      style: TextStyle(fontWeight: FontWeight.w700, color: colores.onSurface),
                    ),
                    TextSpan(text: ' · ${viaje.servicioNombre}'),
                  ],
                ),
              ),
            ),
          ],
          if (pie != null) ...[const SizedBox(height: 14), pie!],
        ],
      ),
    );
  }
}
