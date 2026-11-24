import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/navigation/shell_conductor.dart';
import '../../../core/navigation/shell_pasajero.dart';
import '../../../shared/widgets/widgets.dart';
import '../models/usuario_model.dart';
import '../repositories/sesion_repository.dart';

/// PROVISIONAL (Fase A). Dos botones para entrar rápido con los usuarios de ejemplo
/// y así probar las pantallas antes de que exista el Login real (Paso 26).
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _entrar(BuildContext context, String usuario, String clave) {
    final u = SesionRepository.instancia.iniciarSesion(usuario, clave);
    if (u != null) abrirInicioSegunRol(context, u);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login provisional',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              BotonPrincipal(
                texto: 'Entrar como Nallely (pasajero)',
                onPressed: () => _entrar(context, 'nallely', 'demo123'),
              ),
              const SizedBox(height: 12),
              BotonPrincipal(
                texto: 'Entrar como Abelardo (conductor)',
                tipo: TipoBoton.secundario,
                onPressed: () => _entrar(context, 'abelardo', 'demo456'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, Rutas.registro),
                child: const Text('Ir a Registro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Abre el contenedor que corresponde al rol y borra el historial.
/// (Misma función que tendrá el Login real.)
void abrirInicioSegunRol(BuildContext context, Usuario usuario) {
  ShellPasajero.pestana.value = 0;
  ShellConductor.pestana.value = 0;
  Navigator.pushNamedAndRemoveUntil(
    context,
    usuario.rol == Rol.conductor ? Rutas.conductor : Rutas.pasajero,
    (ruta) => false,
  );
}
