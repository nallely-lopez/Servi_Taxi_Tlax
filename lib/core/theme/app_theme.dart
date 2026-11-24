import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Los dos temas de la app: claro y oscuro.
/// MaterialApp recibe AppTheme.claro en `theme` y AppTheme.oscuro en `darkTheme`.
class AppTheme {
  AppTheme._();

  static final ThemeData claro = _crearTema(
    const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.bosque, // Botones principales
      onPrimary: Colors.white, // Texto encima del primario
      secondary: AppColors.lima,
      onSecondary: AppColors.texto,
      tertiary: AppColors.ambar,
      onTertiary: AppColors.texto,
      error: AppColors.error,
      onError: Colors.white,
      surface: Colors.white, // Tarjetas
      onSurface: AppColors.texto, // Texto principal
      onSurfaceVariant: AppColors.textoSecundario, // Texto secundario
      surfaceContainerHighest: AppColors.suave, // Chips y fondos suaves
      outline: AppColors.borde,
      outlineVariant: AppColors.borde,
    ),
    fondo: AppColors.fondo,
  );

  // En oscuro el verde lima pasa a ser el principal: el verde bosque
  // casi no se distingue sobre un fondo oscuro.
  static final ThemeData oscuro = _crearTema(
    const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.lima,
      onPrimary: AppColors.texto,
      secondary: AppColors.bosque,
      onSecondary: AppColors.textoOscuro,
      tertiary: AppColors.ambar,
      onTertiary: AppColors.texto,
      error: AppColors.errorOscuro,
      onError: AppColors.texto,
      surface: AppColors.tarjetaOscura,
      onSurface: AppColors.textoOscuro,
      onSurfaceVariant: AppColors.textoSecundarioOscuro,
      surfaceContainerHighest: AppColors.suaveOscuro,
      outline: AppColors.bordeOscuro,
      outlineVariant: AppColors.bordeOscuro,
    ),
    fondo: AppColors.fondoOscuro,
  );

  /// Arma un ThemeData con la misma estructura para los dos modos.
  static ThemeData _crearTema(ColorScheme colores, {required Color fondo}) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: colores,
      scaffoldBackgroundColor: fondo,
      textTheme: _textos(colores),
      // Barra superior: mismo color que el fondo y sombra suave al hacer scroll.
      appBarTheme: AppBarTheme(
        backgroundColor: fondo,
        foregroundColor: colores.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 2,
        shadowColor: Colors.black26,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colores.onSurface,
        contentTextStyle: TextStyle(
          fontFamily: 'Poppins',
          color: colores.surface,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      dividerTheme: DividerThemeData(color: colores.outline, space: 1),
    );
  }

  /// Los 7 estilos de texto de la guía de estilo (Poppins).
  static TextTheme _textos(ColorScheme c) {
    return TextTheme(
      // Display 40
      displaySmall: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: c.onSurface,
        height: 1.1,
      ),
      // Título 24
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: c.onSurface,
      ),
      // Subtítulo 18
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: c.onSurface,
      ),
      // Etiqueta 15
      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: c.onSurface,
      ),
      // Texto 14
      bodyMedium: TextStyle(fontSize: 14, color: c.onSurface, height: 1.45),
      // Botón 16
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: c.onSurface,
      ),
      // Pequeño 12
      bodySmall: TextStyle(fontSize: 12, color: c.onSurfaceVariant),
    );
  }
}
