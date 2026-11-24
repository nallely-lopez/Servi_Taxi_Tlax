import 'package:flutter/material.dart';

import '../../../shared/widgets/widgets.dart';

/// PROVISIONAL (Fase A). Se reemplaza en la Fase B por la pantalla real.
class DetalleSolicitudScreen extends StatelessWidget {
  final int viajeId;

  const DetalleSolicitudScreen({super.key, required this.viajeId});

  @override
  Widget build(BuildContext context) {
    return const PantallaEnConstruccion(
      nombre: 'Detalle de la solicitud',
      mostrarAtras: true,
    );
  }
}
