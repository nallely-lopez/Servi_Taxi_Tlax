import 'package:flutter/material.dart';

/// Fila de "Datos de la cuenta": ícono, etiqueta a la izquierda, valor a la derecha.
class FilaDato extends StatelessWidget {
  final IconData icono;
  final String etiqueta;
  final String valor;

  const FilaDato({
    super.key,
    required this.icono,
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Row(
        children: [
          Icon(icono, size: 20, color: colores.onSurfaceVariant),
          const SizedBox(width: 14),
          Text(
            etiqueta,
            style: tema.textTheme.bodyMedium?.copyWith(
              color: colores.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              valor,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: tema.textTheme.labelLarge?.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
