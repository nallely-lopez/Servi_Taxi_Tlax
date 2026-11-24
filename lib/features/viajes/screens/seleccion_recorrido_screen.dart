import 'package:flutter/material.dart';

import '../../../shared/widgets/widgets.dart';
import '../../servicios/servicios.dart';

/// PROVISIONAL (Fase A). Se reemplaza en la Fase B por la pantalla real.
class SeleccionRecorridoScreen extends StatelessWidget {
  final ServicioTransporte servicio;

  const SeleccionRecorridoScreen({super.key, required this.servicio});

  @override
  Widget build(BuildContext context) {
    return const PantallaEnConstruccion(
      nombre: 'Selección de recorrido',
      mostrarAtras: true,
    );
  }
}
