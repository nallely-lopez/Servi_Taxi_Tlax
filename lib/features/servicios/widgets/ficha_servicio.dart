import 'package:flutter/material.dart';

import '../models/servicio_transporte_model.dart';

class FichaServicio extends StatelessWidget {
  final ServicioTransporte servicio;

  const FichaServicio({
    super.key,
    required this.servicio,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.people, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  'Capacidad: ${servicio.capacidad} pasajeros',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _DatoTarifa(
                  etiqueta: 'Tarifa base',
                  valor: servicio.tarifaBase,
                ),
                _DatoTarifa(
                  etiqueta: 'Precio por km',
                  valor: servicio.precioKm,
                  alineacion: CrossAxisAlignment.end,
                ),
              ],
            ),
            const Divider(height: 24),
            const Text(
              'Características:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...servicio.caracteristicas.map(
              (caracteristica) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(caracteristica)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DatoTarifa extends StatelessWidget {
  final String etiqueta;
  final double valor;
  final CrossAxisAlignment alineacion;

  const _DatoTarifa({
    required this.etiqueta,
    required this.valor,
    this.alineacion = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alineacion,
      children: [
        Text(
          etiqueta,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        Text(
          '\$${valor.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
