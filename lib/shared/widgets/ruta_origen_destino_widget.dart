import 'package:flutter/material.dart';

/// Origen y destino con la línea punteada que los une (○ ┊ ●).
class RutaOrigenDestino extends StatelessWidget {
  final String origen;
  final String destino;

  const RutaOrigenDestino({super.key, required this.origen, required this.destino});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final etiqueta = tema.textTheme.bodySmall?.copyWith(fontSize: 13);
    final valor = tema.textTheme.labelLarge?.copyWith(fontSize: 16);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Columna de la izquierda: círculo vacío, línea punteada, círculo lleno.
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colores.primary, width: 2),
                ),
              ),
              for (var i = 0; i < 6; i++)
                Container(
                  width: 1.5,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 1.5),
                  color: colores.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: colores.primary, shape: BoxShape.circle),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Origen', style: etiqueta),
              Text(origen, style: valor),
              const SizedBox(height: 10),
              Text('Destino', style: etiqueta),
              Text(destino, style: valor),
            ],
          ),
        ),
      ],
    );
  }
}
