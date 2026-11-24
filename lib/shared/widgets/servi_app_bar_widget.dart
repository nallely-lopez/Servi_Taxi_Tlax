import 'package:flutter/material.dart';

/// Barra superior única de ServiTlax.
/// Va en `Scaffold(appBar: ServiAppBar(...))`. El Scaffold la deja fija arriba
/// y el contenido hace scroll por debajo; al hacerlo aparece una sombra suave
/// (scrolledUnderElevation del tema).
///
/// Implementa PreferredSizeWidget: es la condición para ir en `appBar`,
/// porque el Scaffold necesita saber cuánto mide la barra.
class ServiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final String? subtitulo;
  final bool mostrarAtras; // Flecha ← para regresar
  final Widget? accion; // Elemento a la derecha: avatar, chip, etc.

  const ServiAppBar({
    super.key,
    required this.titulo,
    this.subtitulo,
    this.mostrarAtras = false,
    this.accion,
  });

  double get _altura => subtitulo == null ? 68 : 80;

  @override
  Size get preferredSize => Size.fromHeight(_altura);

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;

    return AppBar(
      toolbarHeight: _altura,
      automaticallyImplyLeading: false, // Nosotros decidimos si hay flecha
      titleSpacing: mostrarAtras ? 4 : 20,
      leadingWidth: mostrarAtras ? 72 : 0,
      leading: mostrarAtras
          ? Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Center(
                child: Material(
                  color: colores.surface,
                  shape: const CircleBorder(),
                  elevation: 1,
                  shadowColor: Colors.black12,
                  child: IconButton(
                    tooltip: 'Regresar',
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: colores.onSurface,
                    onPressed: () => Navigator.maybePop(context),
                  ),
                ),
              ),
            )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            titulo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: tema.textTheme.headlineSmall?.copyWith(fontSize: 22),
          ),
          if (subtitulo != null)
            Text(
              subtitulo!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: tema.textTheme.bodyMedium?.copyWith(
                color: colores.onSurfaceVariant,
              ),
            ),
        ],
      ),
      actions: [
        if (accion != null)
          Padding(padding: const EdgeInsets.only(right: 20), child: accion),
      ],
    );
  }
}
