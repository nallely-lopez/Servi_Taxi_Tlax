import 'package:flutter/material.dart';

/// Contenedor blanco redondeado con sombra suave: la base de todas las tarjetas.
/// Si recibe onTap, se puede pulsar (con efecto de onda).
class Tarjeta extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final bool resaltada; // Borde de color primario (elemento seleccionado)

  const Tarjeta({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.onTap,
    this.color,
    this.resaltada = false,
  });

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final radio = BorderRadius.circular(24);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radio,
        border: resaltada
            ? Border.all(color: colores.primary, width: 1.5)
            : null,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: color ?? colores.surface,
        borderRadius: radio,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
