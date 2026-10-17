import 'package:flutter/material.dart';

import '../models/viaje.dart';

class DesgloseCosto extends StatelessWidget {
  final Viaje viaje;

  const DesgloseCosto({
    super.key,
    required this.viaje,
  });

  @override
  Widget build(BuildContext context) {
    final costoDistancia = viaje.ruta.distanciaKm * viaje.servicio.precioKm;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _RenglonCosto(
              etiqueta: 'Tarifa base',
              valor: viaje.servicio.tarifaBase,
            ),
            const SizedBox(height: 12),
            _RenglonCosto(
              etiqueta:
                  'Distancia (${viaje.ruta.distanciaKm} km × \$${viaje.servicio.precioKm.toStringAsFixed(2)}/km)',
              valor: costoDistancia,
            ),
            const Divider(height: 24),
            _RenglonCosto(
              etiqueta: 'Total estimado',
              valor: viaje.costoEstimado,
              esTotal: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _RenglonCosto extends StatelessWidget {
  final String etiqueta;
  final double valor;
  final bool esTotal;

  const _RenglonCosto({
    required this.etiqueta,
    required this.valor,
    this.esTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final estilo = esTotal
        ? Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          )
        : Theme.of(context).textTheme.bodyMedium;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(etiqueta, style: estilo)),
        const SizedBox(width: 12),
        Text('\$${valor.toStringAsFixed(2)}', style: estilo),
      ],
    );
  }
}
