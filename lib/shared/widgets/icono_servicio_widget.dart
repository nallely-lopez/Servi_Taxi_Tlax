import 'package:flutter/material.dart';

import '../../core/core.dart';

/// Cuadro redondeado verde pistache con el ícono del servicio.
class IconoServicio extends StatelessWidget {
  final String servicio; // "Mototaxi", "Moto Rápido", "Taxi Rápido"
  final double tamano;

  const IconoServicio({super.key, required this.servicio, this.tamano = 56});

  /// Elige el ícono según el nombre del servicio.
  static IconData iconoDe(String servicio) {
    final nombre = servicio.toLowerCase();
    if (nombre.contains('taxi rápido') || nombre.contains('taxi rapido')) {
      return Icons.local_taxi_rounded;
    }
    if (nombre.contains('moto rápido') || nombre.contains('moto rapido')) {
      return Icons.two_wheeler_rounded;
    }
    return Icons.electric_rickshaw_rounded; // Mototaxi
  }

  @override
  Widget build(BuildContext context) {
    final oscuro = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
        color: oscuro ? AppColors.bosque : AppColors.pistache,
        borderRadius: BorderRadius.circular(tamano * 0.32),
      ),
      child: Icon(
        iconoDe(servicio),
        size: tamano * 0.46,
        color: oscuro ? AppColors.lima : AppColors.bosque,
      ),
    );
  }
}
