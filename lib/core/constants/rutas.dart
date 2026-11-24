/// Nombres de todas las pantallas a las que se navega con Navigator.pushNamed.
/// Escribirlos una sola vez evita errores de dedo como '/cotisacion'.
class Rutas {
  Rutas._();

  static const splash = '/';
  static const login = '/login';
  static const registro = '/registro';

  /// Contenedor con la barra inferior del pasajero (Inicio, Viajes, Perfil).
  static const pasajero = '/pasajero';

  /// Contenedor con la barra inferior del conductor (Solicitudes, Mis viajes, Perfil).
  static const conductor = '/conductor';

  static const detalleServicio = '/servicio';
  static const recorrido = '/recorrido';
  static const cotizacion = '/cotizacion';
  static const confirmacion = '/confirmacion';
  static const detalleSolicitud = '/solicitud';
}
