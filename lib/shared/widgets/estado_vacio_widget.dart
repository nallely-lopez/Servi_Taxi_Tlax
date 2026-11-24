import 'package:flutter/material.dart';

/// Mensaje para cuando una lista está vacía: ícono, título, texto y botón opcional.
/// Ejemplo: "Sin viajes aceptados · Toma una solicitud para empezar."
class EstadoVacio extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String mensaje;
  final String? textoBoton;
  final VoidCallback? onBoton;

  const EstadoVacio({
    super.key,
    required this.icono,
    required this.titulo,
    required this.mensaje,
    this.textoBoton,
    this.onBoton,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: colores.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colores.outline),
      ),
      child: Column(
        children: [
          Icon(icono, size: 36, color: colores.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(titulo, style: tema.textTheme.labelLarge, textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(
            mensaje,
            style: tema.textTheme.bodyMedium?.copyWith(color: colores.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          if (textoBoton != null) ...[
            const SizedBox(height: 18),
            FilledButton(
              onPressed: onBoton,
              style: FilledButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: Text(textoBoton!),
            ),
          ],
        ],
      ),
    );
  }
}
