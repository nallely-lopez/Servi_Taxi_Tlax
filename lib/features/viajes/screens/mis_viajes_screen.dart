import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/widgets/widgets.dart';
import '../../login/login.dart';
import '../models/viaje_model.dart';
import '../repositories/viajes_repository.dart';

/// Pestaña "Viajes" del pasajero: sus viajes filtrados por estado.
class MisViajesScreen extends StatefulWidget {
  const MisViajesScreen({super.key});

  @override
  State<MisViajesScreen> createState() => _MisViajesScreenState();
}

class _MisViajesScreenState extends State<MisViajesScreen> {
  EstadoViaje? _filtro; // null = Todos

  @override
  Widget build(BuildContext context) {
    final usuario = SesionRepository.instancia.usuarioActual.value;
    final repo = ViajesRepository.instancia;

    // ValueListenableBuilder escucha la lista de viajes: si el conductor acepta
    // o finaliza un viaje, esta pantalla se actualiza sola.
    return ValueListenableBuilder<List<Viaje>>(
      valueListenable: repo.viajes,
      builder: (context, _, _) {
        final mios = usuario == null ? <Viaje>[] : repo.dePasajero(usuario.id);
        int contar(EstadoViaje e) => mios.where((v) => v.estado == e).length;
        final visibles = _filtro == null ? mios : mios.where((v) => v.estado == _filtro).toList();

        return Scaffold(
          appBar: ServiAppBar(
            titulo: 'Mis viajes',
            subtitulo: '${mios.length} ${mios.length == 1 ? 'viaje' : 'viajes'} en total',
          ),
          body: Column(
            children: [
              // Pestañas de filtro dentro de una barra blanca redondeada;
              // se deslizan de lado si no caben.
              Container(
                height: 56,
                margin: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _Filtro(
                      texto: 'Todos',
                      cantidad: mios.length,
                      activo: _filtro == null,
                      onTap: () => setState(() => _filtro = null),
                    ),
                    for (final estado in EstadoViaje.values)
                      _Filtro(
                        texto: '${estado.etiqueta}s', // Pendientes, Aceptados, Completados
                        cantidad: contar(estado),
                        activo: _filtro == estado,
                        onTap: () => setState(() => _filtro = estado),
                      ),
                  ],
                ),
              ),
              Expanded(
                // AnimatedSwitcher hace un fundido al cambiar de filtro.
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: ListView(
                    key: ValueKey(_filtro),
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
                    children: [
                      if (visibles.isEmpty)
                        const EstadoVacio(
                          icono: Icons.route_outlined,
                          titulo: 'Sin viajes aquí',
                          mensaje: 'Cuando solicites un viaje aparecerá en esta lista.',
                        ),
                      for (final viaje in visibles) ...[
                        TarjetaViaje(viaje: viaje),
                        const SizedBox(height: 14),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Píldora de filtro: "Todos 3". La activa es verde oscuro con texto lima.
class _Filtro extends StatelessWidget {
  final String texto;
  final int cantidad;
  final bool activo;
  final VoidCallback onTap;

  const _Filtro({required this.texto, required this.cantidad, required this.activo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final oscuro = Theme.of(context).brightness == Brightness.dark;
    final colorTexto = activo
        ? (oscuro ? colores.onPrimary : AppColors.lima)
        : colores.onSurfaceVariant;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: activo ? colores.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text.rich(
          TextSpan(
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: colorTexto),
            children: [
              TextSpan(text: '$texto '),
              TextSpan(text: '$cantidad', style: const TextStyle(fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ),
    );
  }
}
