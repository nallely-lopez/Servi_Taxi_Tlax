/// Funciones para mostrar dinero, distancias y fechas igual en toda la app.
class Formatos {
  Formatos._();

  static const _dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
  static const _meses = [
    'ene',
    'feb',
    'mar',
    'abr',
    'may',
    'jun',
    'jul',
    'ago',
    'sep',
    'oct',
    'nov',
    'dic',
  ];

  /// 27.5 → "$27.50"
  static String dinero(double valor) => '\$${valor.toStringAsFixed(2)}';

  /// 3.5 → "3.5 km"
  static String km(double valor) => '${valor.toStringAsFixed(1)} km';

  /// 11 → "11 min"
  static String minutos(int valor) => '$valor min';

  /// Hoy → "Hoy, 9:20" · otro día → "Lun 16 nov, 7:40"
  static String fechaCorta(DateTime fecha) {
    final ahora = DateTime.now();
    final hora = '${fecha.hour}:${fecha.minute.toString().padLeft(2, '0')}';
    final esHoy =
        fecha.year == ahora.year &&
        fecha.month == ahora.month &&
        fecha.day == ahora.day;
    if (esHoy) return 'Hoy, $hora';
    return '${_dias[fecha.weekday - 1]} ${fecha.day} ${_meses[fecha.month - 1]}, $hora';
  }

  /// ¿La fecha es de hoy?
  static bool esHoy(DateTime fecha) {
    final ahora = DateTime.now();
    return fecha.year == ahora.year &&
        fecha.month == ahora.month &&
        fecha.day == ahora.day;
  }
}
