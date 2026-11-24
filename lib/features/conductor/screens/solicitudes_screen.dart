import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/widgets/widgets.dart';
import '../../login/login.dart';
import '../../viajes/viajes.dart';

/// Pestaña "Solicitudes" del conductor: viajes pendientes que puede tomar.
class SolicitudesScreen extends StatelessWidget {
  const SolicitudesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = SesionRepository.instancia.usuarioActual.value;
    final repo = ViajesRepository.instancia;

    return ValueListenableBuilder<List<Viaje>>(
      valueListenable: repo.viajes,
      builder: (context, _, _) {
        final pendientes = repo.pendientes();
        final n = pendientes.length;

        return Scaffold(
          appBar: ServiAppBar(
            titulo: 'Solicitudes de viaje',
            subtitulo: n == 0
                ? 'No hay viajes esperando'
                : '$n ${n == 1 ? 'viaje espera' : 'viajes esperan'} conductor cerca de ti',
            accion: AvatarIniciales(iniciales: usuario?.iniciales ?? '?'),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: _ChipModoConductor(),
              ),
              const SizedBox(height: 16),
              if (pendientes.isEmpty)
                const EstadoVacio(
                  icono: Icons.inbox_outlined,
                  titulo: 'Sin solicitudes',
                  mensaje: 'Cuando un pasajero pida un viaje aparecerá aquí.',
                ),
              for (final viaje in pendientes) ...[
                TarjetaViaje(
                  viaje: viaje,
                  mostrarPasajero: true,
                  mostrarConductor: false,
                  onTap: () => _abrir(context, viaje),
                  pie: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => _abrir(context, viaje),
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.chevron_right_rounded),
                      label: const Text('Ver solicitud'),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
              ],
            ],
          ),
        );
      },
    );
  }

  void _abrir(BuildContext context, Viaje viaje) =>
      Navigator.pushNamed(context, Rutas.detalleSolicitud, arguments: viaje.id);
}

/// Etiqueta "Modo conductor".
class _ChipModoConductor extends StatelessWidget {
  const _ChipModoConductor();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.bosque,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.directions_car_outlined, size: 16, color: AppColors.lima),
          SizedBox(width: 6),
          Text(
            'Modo conductor',
            style: TextStyle(
              color: AppColors.lima,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
