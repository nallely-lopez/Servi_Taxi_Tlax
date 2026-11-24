import 'package:flutter/material.dart';

import 'estado_vacio_widget.dart';
import 'servi_app_bar_widget.dart';

/// Pantalla provisional. Se usa en la Fase A para que la navegación funcione
/// antes de programar cada pantalla. Cada paso de la Fase B la reemplaza.
/// Al terminar la Fase B este archivo se borra.
class PantallaEnConstruccion extends StatelessWidget {
  final String nombre;
  final bool mostrarAtras;

  const PantallaEnConstruccion({
    super.key,
    required this.nombre,
    this.mostrarAtras = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ServiAppBar(titulo: nombre, mostrarAtras: mostrarAtras),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: EstadoVacio(
          icono: Icons.construction_rounded,
          titulo: 'Pantalla en construcción',
          mensaje: '$nombre se programa en la Fase B.',
        ),
      ),
    );
  }
}
