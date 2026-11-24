import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/navigation/shell_pasajero.dart';
import '../../../shared/widgets/widgets.dart';
import '../models/viaje_model.dart';

/// "¡Viaje solicitado!": confirma que el viaje quedó pendiente.
class ConfirmacionScreen extends StatelessWidget {
  final Viaje viaje;

  const ConfirmacionScreen({super.key, required this.viaje});

  /// Regresa al contenedor del pasajero y abre la pestaña indicada.
  /// popUntil cierra pantallas hasta llegar a la ruta del contenedor.
  void _volver(BuildContext context, int pestana) {
    ShellPasajero.pestana.value = pestana;
    Navigator.popUntil(context, ModalRoute.withName(Rutas.pasajero));
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
          children: [
            // TweenAnimationBuilder anima de 0 a 1: el círculo "crece" al aparecer.
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 550),
                curve: Curves.elasticOut,
                builder: (context, escala, child) => Transform.scale(scale: escala, child: child),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(color: AppColors.lima, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Container(
                    width: 84,
                    height: 84,
                    decoration: const BoxDecoration(color: AppColors.bosque, shape: BoxShape.circle),
                    child: const Icon(Icons.check_rounded, color: AppColors.lima, size: 44),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '¡Viaje solicitado!',
              textAlign: TextAlign.center,
              style: tema.textTheme.headlineSmall?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 8),
            Text(
              'Tu solicitud está pendiente. Un conductor la aceptará en breve.',
              textAlign: TextAlign.center,
              style: tema.textTheme.bodyMedium?.copyWith(
                color: tema.colorScheme.onSurfaceVariant,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 28),
            TarjetaViaje(viaje: viaje),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BotonPrincipal(texto: 'Ver mis viajes', onPressed: () => _volver(context, 1)),
              const SizedBox(height: 10),
              BotonPrincipal(
                texto: 'Volver al inicio',
                tipo: TipoBoton.secundario,
                onPressed: () => _volver(context, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
