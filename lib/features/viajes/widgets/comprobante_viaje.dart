import 'package:flutter/material.dart';

import '../models/viaje.dart';

class ComprobanteViaje extends StatelessWidget {
  final Viaje viaje;

  const ComprobanteViaje({
    super.key,
    required this.viaje,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 56,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Viaje de demostración confirmado',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Este es un viaje académico simulado, sin cobros reales '
                    'ni conductor asignado.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const Divider(height: 32),
            _DetalleViaje(
              etiqueta: 'Servicio',
              valor: viaje.servicio.nombre,
            ),
            const SizedBox(height: 12),
            _DetalleViaje(
              etiqueta: 'Origen',
              valor: viaje.origen.nombre,
            ),
            const SizedBox(height: 12),
            _DetalleViaje(
              etiqueta: 'Destino',
              valor: viaje.destino.nombre,
            ),
            const SizedBox(height: 12),
            _DetalleViaje(
              etiqueta: 'Distancia',
              valor: '${viaje.ruta.distanciaKm.toStringAsFixed(1)} km',
            ),
            const SizedBox(height: 12),
            _DetalleViaje(
              etiqueta: 'Costo estimado',
              valor: '\$${viaje.costoEstimado.toStringAsFixed(2)}',
            ),
          ],
        ),
      ),
    );
  }
}

class _DetalleViaje extends StatelessWidget {
  final String etiqueta;
  final String valor;

  const _DetalleViaje({
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$etiqueta: ',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Expanded(child: Text(valor)),
      ],
    );
  }
}
