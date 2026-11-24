import 'package:flutter/material.dart';

import '../../../core/core.dart';

/// Logotipo: cuadro con el ícono de ubicación + "ServiTlax".
///  - sobreOscuro: true en el Splash (fondo verde bosque).
class LogoServiTlax extends StatelessWidget {
  final double tamano; // Tamaño del texto
  final bool sobreOscuro;

  const LogoServiTlax({super.key, this.tamano = 26, this.sobreOscuro = false});

  @override
  Widget build(BuildContext context) {
    final temaOscuro = Theme.of(context).brightness == Brightness.dark;
    final fondoClaro = sobreOscuro || temaOscuro;

    // "Servi" en un color y "Tlax" en otro, como en la demo.
    final colorServi = fondoClaro ? AppColors.lima : AppColors.bosque;
    final colorTlax = fondoClaro ? Colors.white : AppColors.exito;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: tamano * 2.1,
          height: tamano * 2.1,
          decoration: BoxDecoration(
            color: sobreOscuro ? AppColors.lima : AppColors.bosque,
            borderRadius: BorderRadius.circular(
              tamano * (sobreOscuro ? 0.7 : 1.05),
            ),
          ),
          child: Icon(
            Icons.location_on_outlined,
            size: tamano * 1.2,
            color: sobreOscuro ? AppColors.bosque : AppColors.lima,
          ),
        ),
        SizedBox(width: tamano * 0.45),
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: tamano, fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                text: 'Servi',
                style: TextStyle(color: colorServi),
              ),
              TextSpan(
                text: 'Tlax',
                style: TextStyle(color: colorTlax),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
