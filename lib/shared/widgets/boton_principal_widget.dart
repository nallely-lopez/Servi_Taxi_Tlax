import 'package:flutter/material.dart';

/// Variantes del botón: principal (relleno), secundario (blanco con borde)
/// y peligro (borde rojo, para Cancelar o Cerrar sesión).
enum TipoBoton { principal, secundario, peligro }

/// Botón de ancho completo y forma de píldora, igual en toda la app.
class BotonPrincipal extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed; // null = botón desactivado
  final TipoBoton tipo;
  final IconData? icono;
  final bool cargando; // Muestra un círculo de carga en lugar del texto

  const BotonPrincipal({
    super.key,
    required this.texto,
    required this.onPressed,
    this.tipo = TipoBoton.principal,
    this.icono,
    this.cargando = false,
  });

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    const forma = StadiumBorder(); // Píldora
    const estiloTexto = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

    final contenido = cargando
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: tipo == TipoBoton.principal
                  ? colores.onPrimary
                  : colores.primary,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icono != null) ...[
                Icon(icono, size: 20),
                const SizedBox(width: 8),
              ],
              Flexible(child: Text(texto, overflow: TextOverflow.ellipsis)),
            ],
          );

    final accion = cargando ? null : onPressed;

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: switch (tipo) {
        TipoBoton.principal => FilledButton(
          onPressed: accion,
          style: FilledButton.styleFrom(
            shape: forma,
            textStyle: estiloTexto,
            backgroundColor: colores.primary,
            foregroundColor: colores.onPrimary,
          ),
          child: contenido,
        ),
        TipoBoton.secundario => OutlinedButton(
          onPressed: accion,
          style: OutlinedButton.styleFrom(
            shape: forma,
            textStyle: estiloTexto,
            backgroundColor: colores.surface,
            foregroundColor: colores.onSurface,
            side: BorderSide(color: colores.outline),
          ),
          child: contenido,
        ),
        TipoBoton.peligro => OutlinedButton(
          onPressed: accion,
          style: OutlinedButton.styleFrom(
            shape: forma,
            textStyle: estiloTexto,
            backgroundColor: colores.surface,
            foregroundColor: colores.error,
            side: BorderSide(color: colores.error.withValues(alpha: 0.4)),
          ),
          child: contenido,
        ),
      },
    );
  }
}
