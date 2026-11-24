import 'package:flutter/material.dart';

/// Guarda el tema que eligió el usuario en Perfil → Apariencia.
/// Un ValueNotifier es una "caja" con un valor que avisa a quien la escucha
/// cuando cambia. main.dart la escucha para redibujar la app.
/// Por defecto sigue el modo del sistema (claro u oscuro del celular).
final ValueNotifier<ThemeMode> temaActual = ValueNotifier(ThemeMode.system);
