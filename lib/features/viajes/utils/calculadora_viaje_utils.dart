class CalculadoraViaje {
  /// Calcula la tarifa estimada: tarifaBase + (distanciaKm * precioKm)
  static double calcularCosto({
    required double tarifaBase,
    required double distanciaKm,
    required double precioKm,
  }) {
    return tarifaBase + (distanciaKm * precioKm);
  }
}