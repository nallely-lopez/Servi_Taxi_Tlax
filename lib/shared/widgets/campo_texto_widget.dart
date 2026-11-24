import 'package:flutter/material.dart';

/// Campo de texto con etiqueta arriba, ícono a la izquierda y bordes redondos.
/// Usa TextFormField para poder validar con un Form.
class CampoTexto extends StatefulWidget {
  final String etiqueta;
  final String pista; // Texto gris de ejemplo dentro del campo
  final IconData icono;
  final TextEditingController controller;
  final bool esContrasena; // Oculta el texto y muestra el botón del ojo
  final TextInputType teclado;
  final String? Function(String?)? validar;
  final TextInputAction accionTeclado;

  const CampoTexto({
    super.key,
    required this.etiqueta,
    required this.pista,
    required this.icono,
    required this.controller,
    this.esContrasena = false,
    this.teclado = TextInputType.text,
    this.validar,
    this.accionTeclado = TextInputAction.next,
  });

  @override
  State<CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  late bool _oculto = widget.esContrasena;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final borde = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: colores.outline),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.etiqueta,
          style: tema.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: colores.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: _oculto,
          keyboardType: widget.teclado,
          textInputAction: widget.accionTeclado,
          validator: widget.validar,
          style: tema.textTheme.bodyMedium?.copyWith(fontSize: 15),
          decoration: InputDecoration(
            hintText: widget.pista,
            hintStyle: TextStyle(
              color: colores.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            prefixIcon: Icon(widget.icono, color: colores.onSurfaceVariant),
            suffixIcon: widget.esContrasena
                ? IconButton(
                    tooltip: _oculto
                        ? 'Mostrar contraseña'
                        : 'Ocultar contraseña',
                    icon: Icon(
                      _oculto
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    color: colores.onSurfaceVariant,
                    onPressed: () => setState(() => _oculto = !_oculto),
                  )
                : null,
            filled: true,
            fillColor: colores.surface,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
            border: borde,
            enabledBorder: borde,
            focusedBorder: borde.copyWith(
              borderSide: BorderSide(color: colores.primary, width: 1.6),
            ),
            errorBorder: borde.copyWith(
              borderSide: BorderSide(color: colores.error),
            ),
            focusedErrorBorder: borde.copyWith(
              borderSide: BorderSide(color: colores.error, width: 1.6),
            ),
          ),
        ),
      ],
    );
  }
}
