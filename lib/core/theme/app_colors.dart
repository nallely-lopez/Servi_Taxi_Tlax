import 'package:flutter/material.dart';

/// Paleta oficial de ServiTlax.
/// Es el ÚNICO archivo del proyecto donde se escriben colores con Color(0x...).
/// Las pantallas usan Theme.of(context).colorScheme o estas constantes.
class AppColors {
  AppColors._(); // Constructor privado: esta clase solo guarda constantes.

  // ---------- Modo claro ----------
  static const bosque = Color(0xFF1D4836); // Primario
  static const lima = Color(0xFFD6F573); // Secundario
  static const pistache = Color(0xFFC8DF7F); // Apoyo (íconos de servicio)
  static const fondo = Color(0xFFF1F5EA); // Fondo de las pantallas
  static const ambar = Color(0xFFF4B740); // Acento / estado pendiente
  static const ambarTexto = Color(0xFF8A5A00); // Texto sobre ámbar claro
  static const texto = Color(0xFF14271D); // Texto principal
  static const textoSecundario = Color(0xFF5E6E63); // Subtítulos y etiquetas
  static const borde = Color(0xFFDCE5D2); // Líneas y bordes
  static const suave = Color(0xFFE6EEDB); // Chips y fondos suaves
  static const error = Color(0xFFD64545);
  static const exito = Color(0xFF2F8F4E);

  // ---------- Modo oscuro ----------
  static const fondoOscuro = Color(0xFF0F1A14);
  static const tarjetaOscura = Color(0xFF18261E);
  static const textoOscuro = Color(0xFFE8EFE6);
  static const textoSecundarioOscuro = Color(0xFFA9B8AD);
  static const bordeOscuro = Color(0xFF2A3B31);
  static const suaveOscuro = Color(0xFF1F3027);
  static const errorOscuro = Color(0xFFF07B7B);
  static const exitoOscuro = Color(0xFF5CC27E);
}
