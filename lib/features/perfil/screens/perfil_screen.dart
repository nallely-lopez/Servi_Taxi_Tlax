import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/widgets/widgets.dart';
import '../../login/login.dart';
import '../../viajes/viajes.dart';
import '../widgets/fila_dato_widget.dart';

/// Perfil (lo usan pasajero y conductor): datos de la cuenta,
/// Apariencia (claro, oscuro o sistema) y Cerrar sesión.
class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  void _cerrarSesion(BuildContext context) {
    SesionRepository.instancia.cerrarSesion();
    Navigator.pushNamedAndRemoveUntil(context, Rutas.login, (ruta) => false);
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final usuario = SesionRepository.instancia.usuarioActual.value;
    if (usuario == null) {
      return const SizedBox.shrink(); // Sin sesión no hay perfil
    }
    final esConductor = usuario.rol == Rol.conductor;
    final oscuro = tema.brightness == Brightness.dark;

    return Scaffold(
      appBar: const ServiAppBar(titulo: 'Perfil'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
        children: [
          Center(
            child: AvatarIniciales(iniciales: usuario.iniciales, tamano: 104),
          ),
          const SizedBox(height: 14),
          Text(
            usuario.nombreCompleto,
            textAlign: TextAlign.center,
            style: tema.textTheme.titleMedium?.copyWith(fontSize: 20),
          ),
          Text(
            '@${usuario.usuario}',
            textAlign: TextAlign.center,
            style: tema.textTheme.bodyMedium?.copyWith(
              color: tema.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: esConductor ? AppColors.bosque : AppColors.lima,
                borderRadius: BorderRadius.circular(20),
                border: oscuro && esConductor
                    ? Border.all(color: AppColors.lima.withValues(alpha: 0.4))
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_outlined,
                    size: 16,
                    color: esConductor ? AppColors.lima : AppColors.texto,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    usuario.rol.etiqueta,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: esConductor ? AppColors.lima : AppColors.texto,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 26),
          Text(
            'Datos de la cuenta',
            style: tema.textTheme.titleMedium?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 12),
          // Los viajes realizados se CALCULAN contando los completados (no se guardan).
          ValueListenableBuilder<List<Viaje>>(
            valueListenable: ViajesRepository.instancia.viajes,
            builder: (context, viajes, _) {
              final realizados = viajes
                  .where(
                    (v) =>
                        v.estado == EstadoViaje.completado &&
                        (esConductor
                            ? v.conductorId == usuario.id
                            : v.pasajeroId == usuario.id),
                  )
                  .length;
              return Tarjeta(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    FilaDato(
                      icono: Icons.alternate_email_rounded,
                      etiqueta: 'Usuario',
                      valor: '@${usuario.usuario}',
                    ),
                    const Divider(),
                    FilaDato(
                      icono: Icons.mail_outline_rounded,
                      etiqueta: 'Correo',
                      valor: usuario.correo,
                    ),
                    const Divider(),
                    FilaDato(
                      icono: Icons.verified_outlined,
                      etiqueta: 'Tipo de cuenta',
                      valor: usuario.rol.etiqueta,
                    ),
                    const Divider(),
                    FilaDato(
                      icono: Icons.route_outlined,
                      etiqueta: 'Viajes realizados',
                      valor: '$realizados',
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 26),
          Text(
            'Apariencia',
            style: tema.textTheme.titleMedium?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            'Elige cómo se ve la app.',
            style: tema.textTheme.bodySmall?.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 12),
          // SegmentedButton: botones unidos donde solo uno está activo.
          ValueListenableBuilder<ThemeMode>(
            valueListenable: temaActual,
            builder: (context, modo, _) => SegmentedButton<ThemeMode>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Claro'),
                  icon: Icon(Icons.light_mode_outlined),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Oscuro'),
                  icon: Icon(Icons.dark_mode_outlined),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('Sistema'),
                  icon: Icon(Icons.phone_android_rounded),
                ),
              ],
              selected: {modo},
              // Al elegir, se cambia temaActual y main.dart redibuja toda la app.
              onSelectionChanged: (seleccion) =>
                  temaActual.value = seleccion.first,
            ),
          ),
          const SizedBox(height: 30),
          BotonPrincipal(
            texto: 'Cerrar sesión',
            icono: Icons.logout_rounded,
            tipo: TipoBoton.peligro,
            onPressed: () => _cerrarSesion(context),
          ),
        ],
      ),
    );
  }
}
