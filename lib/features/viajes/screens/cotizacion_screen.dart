import 'package:flutter/material.dart';

import '../../../shared/widgets/boton_principal_widget.dart';
import '../models/viaje.dart';
import '../widgets/desglose_costo.dart';
import '../widgets/resumen_recorrido.dart';

class CotizacionScreen extends StatelessWidget {
  final Viaje viaje;

  const CotizacionScreen({
    super.key,
    required this.viaje,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotización del Viaje'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ResumenRecorrido(viaje: viaje),
            const SizedBox(height: 16),
            DesgloseCosto(viaje: viaje),
            const SizedBox(height: 24),
            BotonPrincipal(
              texto: 'Confirmar Viaje',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Viaje confirmado.')),
                );
              },
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Modificar Recorrido'),
            ),
          ],
        ),
      ),
    );
  }
}
