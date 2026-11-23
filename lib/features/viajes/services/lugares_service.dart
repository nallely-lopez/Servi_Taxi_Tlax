import '../../../core/core.dart';
import '../models/lugar_model.dart';
import '../models/ruta_model.dart';

/// Va por los lugares y las rutas. Hoy: lugares.json y rutas.json.
/// Después: GET /lugares y GET /rutas.
class LugaresService {
  Future<List<Lugar>> obtenerLugares() async {
    final datos = await JsonLocalService.leerLista('lugares.json');
    return datos.map(Lugar.fromJson).toList();
  }

  Future<List<Ruta>> obtenerRutas() async {
    final datos = await JsonLocalService.leerLista('rutas.json');
    return datos.map(Ruta.fromJson).toList();
  }
}
