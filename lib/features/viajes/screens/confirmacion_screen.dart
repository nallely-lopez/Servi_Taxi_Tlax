import 'package:flutter/material.dart';

import '../../../shared/widgets/boton_principal_widget.dart';
import '../models/viaje.dart';
import '../widgets/comprobante_viaje.dart';

class ConfirmacionScreen extends StatelessWidget {
  final Viaje viaje;

  const ConfirmacionScreen({super.key, required this.viaje});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmación de Viaje'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ComprobanteViaje(viaje: viaje),
            const SizedBox(height: 24),
            BotonPrincipal(
              texto: 'Finalizar y Regresar al Catálogo',
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      ),
    );
  }
}
