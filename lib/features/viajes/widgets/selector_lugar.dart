import 'package:flutter/material.dart';

import '../models/lugar.dart';

class SelectorLugar extends StatelessWidget {
  final String etiqueta;
  final Lugar? valorSeleccionado;
  final List<Lugar> lugares;
  final ValueChanged<Lugar?> onChanged;

  const SelectorLugar({
    super.key,
    required this.etiqueta,
    required this.valorSeleccionado,
    required this.lugares,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Lugar>(
      initialValue: valorSeleccionado,
      decoration: InputDecoration(
        labelText: etiqueta,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.location_on, color: Colors.blueAccent),
      ),
      hint: Text('Selecciona $etiqueta'),
      isExpanded: true,
      items: lugares
          .map(
            (lugar) => DropdownMenuItem<Lugar>(
              value: lugar,
              child: Text(lugar.nombre),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
