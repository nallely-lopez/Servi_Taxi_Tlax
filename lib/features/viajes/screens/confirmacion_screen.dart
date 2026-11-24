import 'package:flutter/material.dart';

import '../../../shared/widgets/widgets.dart';
import '../models/viaje_model.dart';

/// PROVISIONAL (Fase A). Se reemplaza en la Fase B por la pantalla real.
class ConfirmacionScreen extends StatelessWidget {
  final Viaje viaje;

  const ConfirmacionScreen({super.key, required this.viaje});

  @override
  Widget build(BuildContext context) {
    return const PantallaEnConstruccion(
      nombre: '¡Viaje solicitado!',
      mostrarAtras: true,
    );
  }
}
