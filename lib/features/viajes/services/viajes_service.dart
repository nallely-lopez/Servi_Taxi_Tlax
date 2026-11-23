import '../../../core/core.dart';
import '../models/viaje_model.dart';

/// Va por los viajes de ejemplo. Hoy: viajes.json. Después: GET /viajes.
class ViajesService {
  Future<List<Viaje>> obtenerViajes() async {
    final datos = await JsonLocalService.leerLista('viajes.json');
    return datos.map(Viaje.fromJson).toList();
  }
}
