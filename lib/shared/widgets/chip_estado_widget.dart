import 'package:flutter/material.dart';

import '../../core/core.dart';

/// Etiqueta de color con el estado del viaje: ● Pendiente, ● Aceptado, ● Completado.
class ChipEstado extends StatelessWidget {
  final EstadoViaje estado;

  const ChipEstado({super.key, required this.estado});

  @override
  Widget build(BuildContext context) {
    final oscuro = Theme.of(context).brightness == Brightness.dark;

    // (fondo, texto) para cada estado
    final (Color fondo, Color texto) = switch (estado) {
      EstadoViaje.pendiente => (
          AppColors.ambar.withValues(alpha: oscuro ? 0.25 : 0.28),
          oscuro ? AppColors.ambar : AppColors.ambarTexto,
        ),
      EstadoViaje.aceptado => (AppColors.lima, AppColors.texto),
      EstadoViaje.completado => (
          oscuro ? AppColors.exitoOscuro : AppColors.bosque,
          oscuro ? AppColors.texto : Colors.white,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: texto, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            estado.etiqueta,
            style: TextStyle(color: texto, fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
