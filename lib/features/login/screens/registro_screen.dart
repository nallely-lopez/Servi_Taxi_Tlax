import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/widgets/widgets.dart';
import '../repositories/sesion_repository.dart';
import 'login_screen.dart';

/// Crear cuenta. Si el usuario activa "¿Deseas ser conductor?" su rol es conductor.
class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formulario = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _usuario = TextEditingController();
  final _correo = TextEditingController();
  final _clave = TextEditingController();
  bool _esConductor = false;

  @override
  void dispose() {
    _nombre.dispose();
    _usuario.dispose();
    _correo.dispose();
    _clave.dispose();
    super.dispose();
  }

  void _crearCuenta() {
    if (!_formulario.currentState!.validate()) return;
    final repo = SesionRepository.instancia;

    if (repo.existeUsuario(_usuario.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ese usuario ya existe. Elige otro.')),
      );
      return;
    }

    final nuevo = repo.registrar(
      nombreCompleto: _nombre.text,
      usuario: _usuario.text,
      correo: _correo.text,
      clave: _clave.text,
      esConductor: _esConductor,
    );
    abrirInicioSegunRol(context, nuevo);
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final oscuro = tema.brightness == Brightness.dark;

    return Scaffold(
      appBar: const ServiAppBar(
        titulo: 'Crear cuenta',
        subtitulo: 'Empieza a moverte por Tlaxiaco',
        mostrarAtras: true,
      ),
      body: Form(
        key: _formulario,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            CampoTexto(
              etiqueta: 'Nombre completo',
              pista: 'Lizeth Nallely López García',
              icono: Icons.person_outline_rounded,
              controller: _nombre,
              validar: (v) => (v == null || v.trim().length < 3)
                  ? 'Escribe tu nombre'
                  : null,
            ),
            const SizedBox(height: 16),
            CampoTexto(
              etiqueta: 'Usuario',
              pista: '@nallely',
              icono: Icons.alternate_email_rounded,
              controller: _usuario,
              validar: (v) {
                final texto = (v ?? '').trim().replaceFirst('@', '');
                if (texto.length < 3) return 'Mínimo 3 caracteres';
                if (texto.contains(' ')) return 'Sin espacios';
                return null;
              },
            ),
            const SizedBox(height: 16),
            CampoTexto(
              etiqueta: 'Correo',
              pista: 'nallely@correo.com',
              icono: Icons.mail_outline_rounded,
              controller: _correo,
              teclado: TextInputType.emailAddress,
              validar: (v) =>
                  (v == null || !v.contains('@') || !v.contains('.'))
                  ? 'Escribe un correo válido'
                  : null,
            ),
            const SizedBox(height: 16),
            CampoTexto(
              etiqueta: 'Contraseña',
              pista: 'Mínimo 8 caracteres',
              icono: Icons.lock_outline_rounded,
              controller: _clave,
              esContrasena: true,
              accionTeclado: TextInputAction.done,
              validar: (v) =>
                  (v == null || v.length < 8) ? 'Mínimo 8 caracteres' : null,
            ),
            const SizedBox(height: 20),
            // Tarjeta del rol conductor
            Tarjeta(
              onTap: () => setState(() => _esConductor = !_esConductor),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: oscuro ? AppColors.bosque : AppColors.pistache,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Icon(
                      Icons.directions_car_outlined,
                      color: oscuro ? AppColors.lima : AppColors.bosque,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¿Deseas ser conductor?',
                          style: tema.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 2),
                        // AnimatedSwitcher cambia el texto con una transición suave.
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            _esConductor
                                ? 'Te registrarás como conductor'
                                : 'Te registrarás como pasajero',
                            key: ValueKey(_esConductor),
                            style: tema.textTheme.bodySmall?.copyWith(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _esConductor,
                    onChanged: (valor) => setState(() => _esConductor = valor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            BotonPrincipal(texto: 'Crear cuenta', onPressed: _crearCuenta),
            const SizedBox(height: 12),
            Text(
              'Tu cuenta se guarda solo mientras la app está abierta. '
              'Se guardará en la base de datos cuando conectemos la API.',
              textAlign: TextAlign.center,
              style: tema.textTheme.bodySmall?.copyWith(
                color: colores.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
