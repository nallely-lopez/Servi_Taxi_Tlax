/// Valores que la app, la API y la base de datos deben escribir EXACTAMENTE igual.
/// Un `enum` es una lista cerrada de opciones: Dart no deja escribir otra.
/// `.name` devuelve el texto: Rol.conductor.name == 'conductor'.
library;

/// Tipo de cuenta del usuario.
enum Rol { pasajero, conductor }

/// Estado de un viaje: pendiente → aceptado → completado.
/// Si el conductor cancela un viaje aceptado, regresa a pendiente.
enum EstadoViaje { pendiente, aceptado, completado }

extension RolTexto on Rol {
  /// Texto para mostrar en pantalla: "Pasajero" o "Conductor".
  String get etiqueta => this == Rol.pasajero ? 'Pasajero' : 'Conductor';
}

extension EstadoViajeTexto on EstadoViaje {
  /// Texto para mostrar en pantalla: "Pendiente", "Aceptado", "Completado".
  String get etiqueta => switch (this) {
    EstadoViaje.pendiente => 'Pendiente',
    EstadoViaje.aceptado => 'Aceptado',
    EstadoViaje.completado => 'Completado',
  };
}
