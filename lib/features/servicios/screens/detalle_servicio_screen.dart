import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/widgets/widgets.dart';
import '../models/servicio_transporte_model.dart';

/// Detalle de un servicio: imagen, descripción, tarifas y características.
class DetalleServicioScreen extends StatelessWidget {
  final ServicioTransporte servicio;

  const DetalleServicioScreen({super.key, required this.servicio});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;

    return Scaffold(
      appBar: const ServiAppBar(titulo: 'Detalle del servicio', mostrarAtras: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          // Imagen del servicio. Si no carga (sin internet), se muestra el ícono.
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: _imagen(colores),
            ),
          ),
          const SizedBox(height: 20),
          Text(servicio.nombre, style: tema.textTheme.headlineSmall?.copyWith(fontSize: 28)),
          const SizedBox(height: 6),
          Text(
            servicio.descripcion,
            style: tema.textTheme.bodyMedium?.copyWith(
              color: colores.onSurfaceVariant,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Chip(
                icono: Icons.people_outline_rounded,
                texto: '${servicio.capacidad} ${servicio.capacidad == 1 ? 'pasajero' : 'pasajeros'}',
                resaltado: true,
              ),
              _Chip(texto: servicio.zona),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _DatoTarifa(
                  icono: Icons.account_balance_wallet_outlined,
                  etiqueta: 'Tarifa base',
                  valor: Formatos.dinero(servicio.tarifaBase),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DatoTarifa(
                  icono: Icons.speed_rounded,
                  etiqueta: 'Precio por km',
                  valor: Formatos.dinero(servicio.precioKm),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Características', style: tema.textTheme.titleMedium?.copyWith(fontSize: 20)),
          const SizedBox(height: 12),
          for (final caracteristica in servicio.caracteristicas)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(color: AppColors.lima, shape: BoxShape.circle),
                    child: const Icon(Icons.check_rounded, size: 18, color: AppColors.texto),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(caracteristica, style: tema.textTheme.bodyMedium)),
                ],
              ),
            ),
        ],
      ),
      // Botón fijo abajo, siempre visible aunque se haga scroll.
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: BotonPrincipal(
            texto: 'Elegir recorrido',
            onPressed: () => Navigator.pushNamed(context, Rutas.recorrido, arguments: servicio),
          ),
        ),
      ),
    );
  }

  /// Si `imagen` empieza con "assets/" se carga de la app (ilustraciones de la demo);
  /// si no, de internet. Si falla, se muestra el ícono del servicio.
  Widget _imagen(ColorScheme colores) {
    Widget respaldo(BuildContext context, Object error, StackTrace? stack) => Container(
          color: colores.surfaceContainerHighest,
          alignment: Alignment.center,
          child: Hero(
            tag: 'servicio-${servicio.id}',
            child: IconoServicio(servicio: servicio.nombre, tamano: 96),
          ),
        );
    if (servicio.imagen.startsWith('assets/')) {
      return Image.asset(servicio.imagen, fit: BoxFit.cover, errorBuilder: respaldo);
    }
    return Image.network(servicio.imagen, fit: BoxFit.cover, errorBuilder: respaldo);
  }
}

class _Chip extends StatelessWidget {
  final IconData? icono;
  final String texto;
  final bool resaltado;

  const _Chip({this.icono, required this.texto, this.resaltado = false});

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final oscuro = Theme.of(context).brightness == Brightness.dark;
    final fondo = resaltado
        ? (oscuro ? AppColors.bosque : AppColors.pistache)
        : colores.surfaceContainerHighest;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(color: fondo, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icono != null) ...[
            Icon(icono, size: 16, color: colores.onSurface),
            const SizedBox(width: 6),
          ],
          Text(texto, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _DatoTarifa extends StatelessWidget {
  final IconData icono;
  final String etiqueta;
  final String valor;

  const _DatoTarifa({required this.icono, required this.etiqueta, required this.valor});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Tarjeta(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, color: tema.colorScheme.onSurface),
          const SizedBox(height: 10),
          Text(etiqueta, style: tema.textTheme.bodySmall?.copyWith(fontSize: 13)),
          Text(valor, style: tema.textTheme.headlineSmall?.copyWith(fontSize: 22)),
        ],
      ),
    );
  }
}
