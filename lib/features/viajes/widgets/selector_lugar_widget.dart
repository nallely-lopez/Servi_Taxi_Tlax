import 'package:flutter/material.dart';

import '../models/lugar_model.dart';

/// Fila "Origen / Tlaxiaco ⌄". Al pulsarla abre una hoja inferior con los lugares.
class SelectorLugar extends StatelessWidget {
  final String etiqueta; // "Origen" o "Destino"
  final Lugar? seleccionado;
  final List<Lugar> lugares;
  final bool relleno; // Círculo lleno (destino) o vacío (origen)
  final ValueChanged<Lugar> alElegir;

  const SelectorLugar({
    super.key,
    required this.etiqueta,
    required this.seleccionado,
    required this.lugares,
    required this.relleno,
    required this.alElegir,
  });

  Future<void> _abrirLista(BuildContext context) async {
    // showModalBottomSheet abre un panel desde abajo y espera la elección.
    final elegido = await showModalBottomSheet<Lugar>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 12),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Text(
                'Elige el ${etiqueta.toLowerCase()}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            for (final lugar in lugares)
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(lugar.nombre),
                subtitle: Text(lugar.descripcion),
                trailing: lugar.id == seleccionado?.id ? const Icon(Icons.check_rounded) : null,
                onTap: () => Navigator.pop(context, lugar),
              ),
          ],
        ),
      ),
    );
    if (elegido != null) alElegir(elegido);
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;

    return InkWell(
      onTap: () => _abrirLista(context),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: relleno ? colores.primary : null,
                border: Border.all(color: colores.primary, width: 2),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(etiqueta, style: tema.textTheme.bodySmall?.copyWith(fontSize: 13)),
                  Text(
                    seleccionado?.nombre ?? 'Elegir',
                    style: tema.textTheme.labelLarge?.copyWith(fontSize: 17),
                  ),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded, color: colores.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
