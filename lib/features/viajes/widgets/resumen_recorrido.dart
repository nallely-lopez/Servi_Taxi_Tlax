import 'package:flutter/material.dart';

import '../models/viaje.dart';

class ResumenRecorrido extends StatelessWidget {
  final Viaje viaje;

  const ResumenRecorrido({
    super.key,
    required this.viaje,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viaje.servicio.nombre,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _DatoRecorrido(
              icono: Icons.trip_origin,
              etiqueta: 'Origen',
              valor: viaje.origen.nombre,
            ),
            const SizedBox(height: 12),
            _DatoRecorrido(
              icono: Icons.location_on,
              etiqueta: 'Destino',
              valor: viaje.destino.nombre,
            ),
            const SizedBox(height: 12),
            _DatoRecorrido(
              icono: Icons.route,
              etiqueta: 'Distancia',
              valor: '${viaje.ruta.distanciaKm} km',
            ),
          ],
        ),
      ),
    );
  }
}

class _DatoRecorrido extends StatelessWidget {
  final IconData icono;
  final String etiqueta;
  final String valor;

  const _DatoRecorrido({
    required this.icono,
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icono, color: Colors.blueAccent),
        const SizedBox(width: 10),
        Text('$etiqueta: ', style: const TextStyle(fontWeight: FontWeight.w600)),
        Expanded(child: Text(valor)),
      ],
    );
  }
}
