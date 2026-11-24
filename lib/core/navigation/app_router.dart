import 'package:flutter/material.dart';

import '../../features/conductor/conductor.dart';
import '../../features/login/login.dart';
import '../../features/servicios/servicios.dart';
import '../../features/viajes/viajes.dart';
import '../core.dart';
import 'shell_conductor.dart';
import 'shell_pasajero.dart';

/// Decide qué pantalla abrir para cada nombre de ruta.
/// MaterialApp lo usa en `onGenerateRoute`. Cuando una pantalla necesita datos
/// (por ejemplo, qué servicio se eligió), llegan en `settings.arguments`.
class AppRouter {
  AppRouter._();

  static Route<dynamic> generarRuta(RouteSettings settings) {
    final args = settings.arguments;

    final Widget pantalla = switch (settings.name) {
      Rutas.splash => const SplashScreen(),
      Rutas.login => const LoginScreen(),
      Rutas.registro => const RegistroScreen(),
      Rutas.pasajero => const ShellPasajero(),
      Rutas.conductor => const ShellConductor(),
      Rutas.detalleServicio => DetalleServicioScreen(
        servicio: args as ServicioTransporte,
      ),
      Rutas.recorrido => SeleccionRecorridoScreen(
        servicio: args as ServicioTransporte,
      ),
      Rutas.cotizacion => CotizacionScreen(cotizacion: args as Cotizacion),
      Rutas.confirmacion => ConfirmacionScreen(viaje: args as Viaje),
      Rutas.detalleSolicitud => DetalleSolicitudScreen(viajeId: args as int),
      _ => const LoginScreen(), // Ruta desconocida: regresar al login
    };

    // `settings` se pasa a la ruta para que ModalRoute.withName la reconozca.
    return _TransicionSuave(pagina: pantalla, settings: settings);
  }
}

/// Transición entre pantallas: la nueva entra deslizándose un poco desde
/// la derecha mientras aparece. Es lo que da la sensación de fluidez.
class _TransicionSuave extends PageRouteBuilder<dynamic> {
  _TransicionSuave({required Widget pagina, required RouteSettings settings})
    : super(
        settings: settings,
        transitionDuration: const Duration(milliseconds: 320),
        reverseTransitionDuration: const Duration(milliseconds: 260),
        pageBuilder: (context, animation, secondaryAnimation) => pagina,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curva = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curva,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0.06, 0),
                end: Offset.zero,
              ).animate(curva),
              child: child,
            ),
          );
        },
      );
}
