import '../../../core/core.dart';
import '../models/servicio_transporte_model.dart';

/// Va por los servicios de transporte. Hoy: servicios.json. Después: GET /servicios.
class ServiciosService {
  Future<List<ServicioTransporte>> obtenerServicios() async {
    final datos = await JsonLocalService.leerLista('servicios.json');
    return datos.map(ServicioTransporte.fromJson).toList();
  }
}
