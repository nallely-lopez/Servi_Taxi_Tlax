import 'package:flutter/material.dart';

class CampoAcceso extends StatelessWidget {
  final String etiqueta;
  final TextEditingController controlador;
  final IconData icono;
  final bool ocultarTexto;

  const CampoAcceso({
    super.key,
    required this.etiqueta,
    required this.controlador,
    required this.icono,
    this.ocultarTexto = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      obscureText: ocultarTexto,
      decoration: InputDecoration(
        labelText: etiqueta,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icono),
      ),
    );
  }
}
