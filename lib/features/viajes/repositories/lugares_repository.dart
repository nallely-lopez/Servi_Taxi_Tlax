import '../models/lugar_model.dart';
import '../models/ruta_model.dart';
import '../services/lugares_service.dart';

/// Lo que usan las pantallas para los lugares y para buscar la ruta entre dos.
class LugaresRepository {
  LugaresRepository._();
  static final LugaresRepository instancia = LugaresRepository._();

  final LugaresService _service = LugaresService();
  List<Lugar> _lugares = [];
  List<Ruta> _rutas = [];

  Future<void> cargar() async {
    if (_lugares.isNotEmpty) return;
    _lugares = await _service.obtenerLugares();
    _rutas = await _service.obtenerRutas();
  }

  List<Lugar> get lugares => List.unmodifiable(_lugares);

  /// Ruta de origen a destino, o null si no existe.
  Ruta? buscarRuta(int origenId, int destinoId) {
    for (final r in _rutas) {
      if (r.origenId == origenId && r.destinoId == destinoId) return r;
    }
    return null;
  }
}
