import '../models/servicio_transporte_model.dart';
import '../services/servicios_service.dart';

/// Lo que usan las pantallas para obtener los servicios.
/// Guarda la lista después de la primera carga para no leer el archivo cada vez.
class ServiciosRepository {
  ServiciosRepository._();
  static final ServiciosRepository instancia = ServiciosRepository._();

  final ServiciosService _service = ServiciosService();
  List<ServicioTransporte> _servicios = [];

  Future<List<ServicioTransporte>> obtenerServicios() async {
    if (_servicios.isEmpty) {
      _servicios = await _service.obtenerServicios();
    }
    return _servicios;
  }

  ServicioTransporte? buscarPorId(int id) {
    for (final s in _servicios) {
      if (s.id == id) return s;
    }
    return null;
  }
}
