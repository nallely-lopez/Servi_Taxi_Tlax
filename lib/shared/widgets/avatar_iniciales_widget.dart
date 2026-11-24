import 'package:flutter/material.dart';

import '../../core/core.dart';

/// Círculo verde con las iniciales del usuario: "LL", "AO".
class AvatarIniciales extends StatelessWidget {
  final String iniciales;
  final double tamano;

  const AvatarIniciales({super.key, required this.iniciales, this.tamano = 48});

  @override
  Widget build(BuildContext context) {
    final oscuro = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: tamano,
      height: tamano,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // En oscuro el círculo es lima con letras oscuras para que contraste.
        color: oscuro ? AppColors.lima : AppColors.bosque,
        shape: BoxShape.circle,
      ),
      child: Text(
        iniciales,
        style: TextStyle(
          color: oscuro ? AppColors.texto : AppColors.lima,
          fontWeight: FontWeight.w700,
          fontSize: tamano * 0.34,
        ),
      ),
    );
  }
}
