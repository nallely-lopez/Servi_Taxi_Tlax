import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/navigation/shell_conductor.dart';
import '../../../core/navigation/shell_pasajero.dart';
import '../../../shared/widgets/widgets.dart';
import '../models/usuario_model.dart';
import '../repositories/sesion_repository.dart';
import '../widgets/logo_servitlax_widget.dart';

/// Inicio de sesión. Según el rol del usuario abre el contenedor
/// del pasajero o el del conductor.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // La GlobalKey permite pedirle al Form que valide todos sus campos.
  final _formulario = GlobalKey<FormState>();
  final _usuario = TextEditingController();
  final _clave = TextEditingController();
  bool _mostrarRecuperar = false; // Muestra el aviso de recuperar contraseña

  @override
  void dispose() {
    _usuario.dispose();
    _clave.dispose();
    super.dispose();
  }

  void _iniciarSesion() {
    // validate() ejecuta el `validar` de cada CampoTexto; si alguno falla, se detiene.
    if (!_formulario.currentState!.validate()) return;

    final usuario = SesionRepository.instancia.iniciarSesion(
      _usuario.text,
      _clave.text,
    );
    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos.')),
      );
      return;
    }
    abrirInicioSegunRol(context, usuario);
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          // SingleChildScrollView evita que el teclado tape los campos.
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: _formulario,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: LogoServiTlax()),
                  const SizedBox(height: 28),
                  Text(
                    '¡Bienvenido!',
                    textAlign: TextAlign.center,
                    style: tema.textTheme.headlineSmall?.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Inicia sesión para pedir tu viaje',
                    textAlign: TextAlign.center,
                    style: tema.textTheme.bodyMedium?.copyWith(
                      color: colores.onSurfaceVariant,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CampoTexto(
                    etiqueta: 'Usuario',
                    pista: '@nallely',
                    icono: Icons.person_outline_rounded,
                    controller: _usuario,
                    validar: (v) => (v == null || v.trim().isEmpty)
                        ? 'Escribe tu usuario'
                        : null,
                  ),
                  const SizedBox(height: 18),
                  CampoTexto(
                    etiqueta: 'Contraseña',
                    pista: '••••••••',
                    icono: Icons.lock_outline_rounded,
                    controller: _clave,
                    esContrasena: true,
                    accionTeclado: TextInputAction.done,
                    validar: (v) => (v == null || v.isEmpty)
                        ? 'Escribe tu contraseña'
                        : null,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => setState(
                        () => _mostrarRecuperar = !_mostrarRecuperar,
                      ),
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: colores.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // AnimatedSize hace que el aviso aparezca y desaparezca suavemente.
                  AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    child: _mostrarRecuperar
                        ? Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 4, bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: tema.brightness == Brightness.dark
                                  ? AppColors.bosque
                                  : AppColors.lima.withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Te enviaremos un enlace para recuperar tu contraseña a tu correo.',
                              style: tema.textTheme.bodyMedium,
                            ),
                          )
                        : const SizedBox(width: double.infinity),
                  ),
                  const SizedBox(height: 12),
                  BotonPrincipal(
                    texto: 'Iniciar sesión',
                    onPressed: _iniciarSesion,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿No tienes cuenta?',
                        style: TextStyle(color: colores.onSurfaceVariant),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Rutas.registro),
                        child: Text(
                          'Regístrate',
                          style: TextStyle(
                            color: colores.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Abre el contenedor que corresponde al rol y borra el historial
/// (para que "atrás" no regrese al login). La usa también Registro.
void abrirInicioSegunRol(BuildContext context, Usuario usuario) {
  final esConductor = usuario.rol == Rol.conductor;
  // Siempre empezar en la primera pestaña.
  ShellPasajero.pestana.value = 0;
  ShellConductor.pestana.value = 0;
  Navigator.pushNamedAndRemoveUntil(
    context,
    esConductor ? Rutas.conductor : Rutas.pasajero,
    (ruta) => false, // false = quitar todas las pantallas anteriores
  );
}
