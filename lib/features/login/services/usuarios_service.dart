import '../../../core/core.dart';
import '../models/usuario_model.dart';

/// Va por los usuarios. Hoy los lee de assets/data/usuarios.json.
/// En la etapa de la API, este archivo hará POST /auth/login y POST /auth/registro.
class UsuariosService {
  Future<List<Usuario>> obtenerUsuarios() async {
    final datos = await JsonLocalService.leerLista('usuarios.json');
    return datos.map(Usuario.fromJson).toList();
  }
}
