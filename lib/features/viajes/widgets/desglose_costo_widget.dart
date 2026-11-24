import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/widgets/widgets.dart';
import '../models/cotizacion_model.dart';

/// "Desglose del costo": tarifa base, distancia × precio y el total resaltado.
class DesgloseCosto extends StatelessWidget {
  final Cotizacion cotizacion;

  const DesgloseCosto({super.key, required this.cotizacion});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final servicio = cotizacion.servicio;

    Widget fila(String etiqueta, double valor) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  etiqueta,
                  style: tema.textTheme.bodyMedium?.copyWith(color: colores.onSurfaceVariant),
                ),
              ),
              Text(Formatos.dinero(valor), style: tema.textTheme.labelLarge),
            ],
          ),
        );

    return Tarjeta(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fila('Tarifa base', servicio.tarifaBase),
          fila(
            'Distancia (${Formatos.km(cotizacion.ruta.distanciaKm)} × ${Formatos.dinero(servicio.precioKm)})',
            cotizacion.costoDistancia,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.bosque,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Total',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Text(
                  Formatos.dinero(cotizacion.total),
                  style: const TextStyle(
                    color: AppColors.lima,
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Pago en efectivo al conductor al llegar a tu destino.',
            style: tema.textTheme.bodySmall?.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
