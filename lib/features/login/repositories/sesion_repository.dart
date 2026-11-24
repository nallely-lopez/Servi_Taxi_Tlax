import 'package:flutter/foundation.dart';

import '../../../core/core.dart';
import '../models/usuario_model.dart';
import '../services/usuarios_service.dart';

/// Lo que usan las pantallas para iniciar sesión, registrarse y saber quién entró.
/// Es un "singleton": existe una sola instancia para toda la app
/// (SesionRepository.instancia), así todas las pantallas ven el mismo usuario.
class SesionRepository {
  SesionRepository._();
  static final SesionRepository instancia = SesionRepository._();

  final UsuariosService _service = UsuariosService();
  final List<Usuario> _usuarios = [];

  /// Usuario que inició sesión (null si nadie).
  final ValueNotifier<Usuario?> usuarioActual = ValueNotifier(null);

  /// Carga los usuarios una sola vez (la llama el Splash).
  Future<void> cargar() async {
    if (_usuarios.isNotEmpty) return;
    _usuarios.addAll(await _service.obtenerUsuarios());
  }

  /// Devuelve el usuario si el usuario y la clave coinciden; si no, null.
  Usuario? iniciarSesion(String usuario, String clave) {
    final limpio = usuario.trim().replaceFirst('@', '').toLowerCase();
    for (final u in _usuarios) {
      if (u.usuario == limpio && u.claveAcceso == clave) {
        usuarioActual.value = u;
        return u;
      }
    }
    return null;
  }

  /// ¿Ya existe ese nombre de usuario?
  bool existeUsuario(String usuario) {
    final limpio = usuario.trim().replaceFirst('@', '').toLowerCase();
    return _usuarios.any((u) => u.usuario == limpio);
  }

  /// Crea la cuenta (solo en memoria por ahora) e inicia sesión con ella.
  Usuario registrar({
    required String nombreCompleto,
    required String usuario,
    required String correo,
    required String clave,
    required bool esConductor,
  }) {
    final nuevo = Usuario(
      id: _usuarios.length + 1,
      nombreCompleto: nombreCompleto.trim(),
      nombreCorto: nombreCompleto.trim().split(' ').first,
      usuario: usuario.trim().replaceFirst('@', '').toLowerCase(),
      correo: correo.trim(),
      claveAcceso: clave,
      rol: esConductor ? Rol.conductor : Rol.pasajero,
    );
    _usuarios.add(nuevo);
    usuarioActual.value = nuevo;
    return nuevo;
  }

  Usuario? buscarPorId(int id) {
    for (final u in _usuarios) {
      if (u.id == id) return u;
    }
    return null;
  }

  void cerrarSesion() => usuarioActual.value = null;
}
