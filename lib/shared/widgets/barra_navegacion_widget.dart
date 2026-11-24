import 'package:flutter/material.dart';

import '../../core/core.dart';

/// Un botón de la barra inferior.
class ItemNavegacion {
  final IconData icono;
  final String etiqueta;
  const ItemNavegacion(this.icono, this.etiqueta);
}

/// Barra inferior en forma de píldora verde oscuro.
/// El botón activo se muestra en verde lima con su texto; los demás, solo el ícono.
/// AnimatedContainer anima el cambio de tamaño y color: eso da la fluidez.
class BarraNavegacion extends StatelessWidget {
  final int indiceActual;
  final ValueChanged<int> alCambiar;
  final List<ItemNavegacion> items;

  const BarraNavegacion({
    super.key,
    required this.indiceActual,
    required this.alCambiar,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final oscuro = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: oscuro ? AppColors.tarjetaOscura : AppColors.bosque,
          borderRadius: BorderRadius.circular(36),
          border: oscuro ? Border.all(color: AppColors.bordeOscuro) : null,
          boxShadow: const [
            BoxShadow(color: Color(0x22000000), blurRadius: 20, offset: Offset(0, 8)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var i = 0; i < items.length; i++)
              _BotonBarra(
                item: items[i],
                activo: i == indiceActual,
                onTap: () => alCambiar(i),
              ),
          ],
        ),
      ),
    );
  }
}

class _BotonBarra extends StatelessWidget {
  final ItemNavegacion item;
  final bool activo;
  final VoidCallback onTap;

  const _BotonBarra({required this.item, required this.activo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorIcono = activo ? AppColors.texto : AppColors.textoOscuro;

    return Semantics(
      button: true,
      selected: activo,
      label: item.etiqueta,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(horizontal: activo ? 20 : 16, vertical: 12),
          decoration: BoxDecoration(
            color: activo ? AppColors.lima : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icono, color: colorIcono, size: 22),
              // AnimatedSize hace que el texto aparezca y desaparezca suavemente.
              AnimatedSize(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                child: activo
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          item.etiqueta,
                          style: const TextStyle(
                            color: AppColors.texto,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
