import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/navigation/shell_conductor.dart';
import '../../../shared/widgets/widgets.dart';
import '../../login/login.dart';
import '../../viajes/viajes.dart';

/// Pestaña "Mis viajes" del conductor: viajes aceptados (con Cancelar y
/// Finalizar) y los completados de hoy con su total.
class ViajesAceptadosScreen extends StatelessWidget {
  const ViajesAceptadosScreen({super.key});

  /// Pide confirmación con un diálogo; devuelve true si el usuario aceptó.
  Future<bool> _confirmar(BuildContext context, String titulo, String mensaje) async {
    final respuesta = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sí')),
        ],
      ),
    );
    return respuesta ?? false; // null si se cerró tocando fuera
  }

  Future<void> _cancelar(BuildContext context, Viaje viaje) async {
    final ok = await _confirmar(context, 'Cancelar viaje',
        'El viaje ${viaje.folio} regresará a pendiente para que otro conductor lo tome.');
    if (!ok || !context.mounted) return;
    ViajesRepository.instancia.cancelar(viaje.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cancelaste el viaje ${viaje.folio}.')),
    );
  }

  Future<void> _finalizar(BuildContext context, Viaje viaje) async {
    final ok = await _confirmar(context, 'Finalizar viaje',
        '¿Ya llegaron al destino y recibiste ${Formatos.dinero(viaje.total)}?');
    if (!ok || !context.mounted) return;
    ViajesRepository.instancia.finalizar(viaje.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viaje ${viaje.folio} completado.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final verde = tema.brightness == Brightness.dark ? AppColors.exitoOscuro : AppColors.exito;
    final conductor = SesionRepository.instancia.usuarioActual.value;
    final repo = ViajesRepository.instancia;

    return ValueListenableBuilder<List<Viaje>>(
      valueListenable: repo.viajes,
      builder: (context, _, _) {
        final aceptados = conductor == null ? <Viaje>[] : repo.aceptadosDe(conductor.id);
        final hoy = conductor == null
            ? <Viaje>[]
            : repo.completadosDe(conductor.id).where((v) => Formatos.esHoy(v.fecha)).toList();
        final totalHoy = hoy.fold<double>(0, (suma, v) => suma + v.total);

        return Scaffold(
          appBar: ServiAppBar(
            titulo: 'Viajes aceptados',
            subtitulo: aceptados.isEmpty ? 'No tienes viajes en curso' : '${aceptados.length} en curso',
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
            children: [
              if (aceptados.isEmpty)
                EstadoVacio(
                  icono: Icons.checklist_rounded,
                  titulo: 'Sin viajes aceptados',
                  mensaje: 'Toma una solicitud para empezar.',
                  textoBoton: 'Ver solicitudes',
                  onBoton: () => ShellConductor.pestana.value = 0,
                ),
              for (final viaje in aceptados) ...[
                TarjetaViaje(
                  viaje: viaje,
                  mostrarPasajero: true,
                  mostrarConductor: false,
                  pie: Row(
                    children: [
                      Expanded(
                        child: BotonPrincipal(
                          texto: 'Cancelar',
                          tipo: TipoBoton.peligro,
                          onPressed: () => _cancelar(context, viaje),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: BotonPrincipal(
                          texto: 'Finalizar viaje',
                          onPressed: () => _finalizar(context, viaje),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
              ],
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: Text('Completados hoy', style: tema.textTheme.titleMedium?.copyWith(fontSize: 20))),
                  Text(
                    Formatos.dinero(totalHoy),
                    style: tema.textTheme.labelLarge?.copyWith(color: verde),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (hoy.isEmpty)
                Text('Todavía no completas viajes hoy.', style: TextStyle(color: colores.onSurfaceVariant)),
              // Todos los completados de hoy en una sola tarjeta, separados por líneas.
              if (hoy.isNotEmpty)
                Tarjeta(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (var i = 0; i < hoy.length; i++) ...[
                        if (i > 0) const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle_outline_rounded, color: verde),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${hoy[i].origen} → ${hoy[i].destino}', style: tema.textTheme.labelLarge),
                                    Text(hoy[i].pasajeroNombre,
                                        style: tema.textTheme.bodySmall?.copyWith(fontSize: 13)),
                                  ],
                                ),
                              ),
                              Text(Formatos.dinero(hoy[i].total), style: tema.textTheme.labelLarge),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
