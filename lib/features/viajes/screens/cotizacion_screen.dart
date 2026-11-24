import 'package:flutter/material.dart';

import '../../../shared/widgets/widgets.dart';
import '../models/cotizacion_model.dart';

/// PROVISIONAL (Fase A). Se reemplaza en la Fase B por la pantalla real.
class CotizacionScreen extends StatelessWidget {
  final Cotizacion cotizacion;

  const CotizacionScreen({super.key, required this.cotizacion});

  @override
  Widget build(BuildContext context) {
    return const PantallaEnConstruccion(
      nombre: 'Cotización',
      mostrarAtras: true,
    );
  }
}
