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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.people, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  'Capacidad: ${servicio.capacidad} pasajeros',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tarifa base', style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text(
                      '\$${servicio.tarifaBase.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Precio por km', style: TextStyle(color: Colors.grey, fontSize: 13)),
                    Text(
                      '\$${servicio.precioKm.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
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
              (c) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, size: 16, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(child: Text(c, style: const TextStyle(fontSize: 14))),
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