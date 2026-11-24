import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/navigation/shell_conductor.dart';
import '../../../shared/widgets/widgets.dart';
import '../../login/login.dart';
import '../../viajes/viajes.dart';

/// Detalle de una solicitud: mapa, pasajero, recorrido y ganancia.
/// "Aceptar viaje" la pasa a aceptado y abre la pestaña Mis viajes.
/// Recibe el id (no el viaje) para leer siempre el estado más reciente.
class DetalleSolicitudScreen extends StatelessWidget {
  final int viajeId;

  const DetalleSolicitudScreen({super.key, required this.viajeId});

  void _aceptar(BuildContext context, Viaje viaje) {
    final conductor = SesionRepository.instancia.usuarioActual.value;
    if (conductor == null) return;
    try {
      ViajesRepository.instancia.aceptar(viaje.id, conductor);
      ShellConductor.pestana.value = 1; // Mostrar "Mis viajes" al regresar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Aceptaste el viaje ${viaje.folio}.')),
      );
      Navigator.pop(context);
    } on StateError catch (e) {
      // Otro conductor lo tomó primero o ya no está pendiente.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final repo = ViajesRepository.instancia;

    return ValueListenableBuilder<List<Viaje>>(
      valueListenable: repo.viajes,
      builder: (context, _, _) {
        final viaje = repo.buscarPorId(viajeId);
        if (viaje == null) {
          return const Scaffold(
            appBar: ServiAppBar(
              titulo: 'Detalle de la solicitud',
              mostrarAtras: true,
            ),
            body: Center(child: Text('Esta solicitud ya no existe.')),
          );
        }
        final pasajero = SesionRepository.instancia.buscarPorId(
          viaje.pasajeroId,
        );
        final pendiente = viaje.estado == EstadoViaje.pendiente;

        return Scaffold(
          appBar: ServiAppBar(
            titulo: 'Detalle de la solicitud',
            mostrarAtras: true,
            accion: ChipEstado(estado: viaje.estado),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            children: [
              MapaRecorrido(origen: viaje.origen, destino: viaje.destino),
              const SizedBox(height: 16),
              // Pasajero
              Tarjeta(
                child: Row(
                  children: [
                    AvatarIniciales(
                      iniciales: pasajero?.iniciales ?? '?',
                      tamano: 54,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viaje.pasajeroNombre,
                            style: tema.textTheme.labelLarge,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: AppColors.ambar,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${(pasajero?.calificacion ?? 5.0).toStringAsFixed(1)} · @${pasajero?.usuario ?? 'pasajero'}',
                                style: tema.textTheme.bodySmall?.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton.filledTonal(
                      tooltip: 'Llamar al pasajero',
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(
                            SnackBar(
                              content: Text(
                                'Llamando a ${viaje.pasajeroNombre}...',
                              ),
                            ),
                          ),
                      icon: const Icon(Icons.phone_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Tarjeta(
                child: RutaOrigenDestino(
                  origen: viaje.origen,
                  destino: viaje.destino,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ChipDato(
                    icono: IconoServicio.iconoDe(viaje.servicioNombre),
                    texto: viaje.servicioNombre,
                    resaltado: true,
                  ),
                  _ChipDato(
                    icono: Icons.straighten_rounded,
                    texto: Formatos.km(viaje.distanciaKm),
                  ),
                  _ChipDato(
                    icono: Icons.schedule_rounded,
                    texto: Formatos.minutos(viaje.minutos),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Ganancia estimada
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.bosque,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ganancia estimada',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          Text(
                            'Pago en efectivo',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      Formatos.dinero(viaje.total),
                      style: const TextStyle(
                        color: AppColors.lima,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: BotonPrincipal(
                texto: pendiente ? 'Aceptar viaje' : 'Este viaje ya fue tomado',
                onPressed: pendiente ? () => _aceptar(context, viaje) : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ChipDato extends StatelessWidget {
  final IconData icono;
  final String texto;
  final bool resaltado;

  const _ChipDato({
    required this.icono,
    required this.texto,
    this.resaltado = false,
  });

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final oscuro = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: resaltado
            ? (oscuro ? AppColors.bosque : AppColors.pistache)
            : colores.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 16),
          const SizedBox(width: 6),
          Text(
            texto,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
