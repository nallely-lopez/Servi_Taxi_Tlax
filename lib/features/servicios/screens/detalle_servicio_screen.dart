import 'package:flutter/material.dart';

import '../../../shared/widgets/widgets.dart';
import '../models/servicio_transporte_model.dart';

/// PROVISIONAL (Fase A). Se reemplaza en la Fase B por la pantalla real.
class DetalleServicioScreen extends StatelessWidget {
  final ServicioTransporte servicio;

  const DetalleServicioScreen({super.key, required this.servicio});

  @override
  Widget build(BuildContext context) {
    return const PantallaEnConstruccion(
      nombre: 'Detalle del servicio',
      mostrarAtras: true,
    );
  }
}
