import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/widgets/widgets.dart';
import '../models/servicio_transporte_model.dart';

/// Tarjeta de un servicio en el catálogo de Inicio:
/// ícono, nombre, capacidad, descripción corta y "Desde $10.00".
class TarjetaServicio extends StatelessWidget {
  final ServicioTransporte servicio;
  final VoidCallback onTap;

  const TarjetaServicio({super.key, required this.servicio, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;

    return Tarjeta(
      onTap: onTap,
      child: Row(
        children: [
          // Hero: el ícono "vuela" a la pantalla de detalle al abrirla.
          Hero(
            tag: 'servicio-${servicio.id}',
            child: IconoServicio(servicio: servicio.nombre, tamano: 64),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        servicio.nombre,
                        style: tema.textTheme.labelLarge?.copyWith(fontSize: 17),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.people_outline_rounded, size: 16, color: colores.onSurfaceVariant),
                    const SizedBox(width: 2),
                    Text('${servicio.capacidad}', style: tema.textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  servicio.descripcion,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: tema.textTheme.bodyMedium?.copyWith(color: colores.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Text(
                  'Desde ${Formatos.dinero(servicio.tarifaBase)}',
                  style: tema.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: colores.onSurfaceVariant),
        ],
      ),
    );
  }
}
