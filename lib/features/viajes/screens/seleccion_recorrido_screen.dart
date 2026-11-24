import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/widgets/widgets.dart';
import '../../servicios/servicios.dart';
import '../models/cotizacion_model.dart';
import '../models/lugar_model.dart';
import '../repositories/lugares_repository.dart';
import '../widgets/selector_lugar_widget.dart';

/// Elegir origen y destino. Muestra los lugares frecuentes con su distancia
/// y tiempo desde el origen. "Cotizar viaje" abre la Cotización.
class SeleccionRecorridoScreen extends StatefulWidget {
  final ServicioTransporte servicio;

  const SeleccionRecorridoScreen({super.key, required this.servicio});

  @override
  State<SeleccionRecorridoScreen> createState() => _SeleccionRecorridoScreenState();
}

class _SeleccionRecorridoScreenState extends State<SeleccionRecorridoScreen> {
  final _repo = LugaresRepository.instancia;
  Lugar? _origen;
  Lugar? _destino;

  @override
  void initState() {
    super.initState();
    // Por defecto el origen es Tlaxiaco (el primer lugar).
    if (_repo.lugares.isNotEmpty) _origen = _repo.lugares.first;
  }

  /// Intercambia origen y destino (botón ⇅).
  void _intercambiar() => setState(() {
        final temporal = _origen;
        _origen = _destino;
        _destino = temporal;
      });

  void _cotizar() {
    final origen = _origen;
    final destino = _destino;
    String? error;
    if (origen == null || destino == null) {
      error = 'Elige el origen y el destino.';
    } else if (origen.id == destino.id) {
      error = 'El origen y el destino deben ser diferentes.';
    }
    final ruta = (origen != null && destino != null) ? _repo.buscarRuta(origen.id, destino.id) : null;
    if (error == null && ruta == null) {
      error = 'Todavía no hay una ruta entre esos dos lugares.';
    }
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    Navigator.pushNamed(
      context,
      Rutas.cotizacion,
      arguments: Cotizacion(
        servicio: widget.servicio,
        origen: origen!,
        destino: destino!,
        ruta: ruta!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final colores = tema.colorScheme;
    final oscuro = tema.brightness == Brightness.dark;

    // Lugares frecuentes: los que tienen ruta desde el origen elegido.
    final frecuentes = _origen == null
        ? <Lugar>[]
        : _repo.lugares
            .where((l) => l.id != _origen!.id && _repo.buscarRuta(_origen!.id, l.id) != null)
            .toList();

    return Scaffold(
      appBar: ServiAppBar(
        titulo: 'Selección de recorrido',
        mostrarAtras: true,
        accion: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: oscuro ? AppColors.bosque : AppColors.pistache,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(IconoServicio.iconoDe(widget.servicio.nombre), size: 16),
              const SizedBox(width: 4),
              Text(widget.servicio.nombre,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          MapaRecorrido(origen: _origen?.nombre ?? 'Origen', destino: _destino?.nombre ?? 'Destino'),
          const SizedBox(height: 16),
          // Tarjeta con los dos selectores y el botón para intercambiarlos.
          Tarjeta(
            padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  children: [
                    SelectorLugar(
                      etiqueta: 'Origen',
                      seleccionado: _origen,
                      lugares: _repo.lugares,
                      relleno: false,
                      alElegir: (l) => setState(() => _origen = l),
                    ),
                    const Divider(),
                    SelectorLugar(
                      etiqueta: 'Destino',
                      seleccionado: _destino,
                      lugares: _repo.lugares,
                      relleno: true,
                      alElegir: (l) => setState(() => _destino = l),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 36),
                  child: IconButton.filled(
                    tooltip: 'Intercambiar origen y destino',
                    onPressed: _intercambiar,
                    icon: const Icon(Icons.swap_vert_rounded),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Lugares frecuentes', style: tema.textTheme.titleMedium?.copyWith(fontSize: 20)),
          const SizedBox(height: 12),
          for (final lugar in frecuentes) ...[
            _LugarFrecuente(
              lugar: lugar,
              seleccionado: lugar.id == _destino?.id,
              distanciaKm: _repo.buscarRuta(_origen!.id, lugar.id)!.distanciaKm,
              minutos: _repo.buscarRuta(_origen!.id, lugar.id)!.minutos,
              onTap: () => setState(() => _destino = lugar),
            ),
            const SizedBox(height: 10),
          ],
          if (frecuentes.isEmpty)
            Text(
              'No hay lugares frecuentes desde este origen.',
              style: TextStyle(color: colores.onSurfaceVariant),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: BotonPrincipal(texto: 'Cotizar viaje', onPressed: _cotizar),
        ),
      ),
    );
  }
}

/// Fila de un lugar frecuente: ícono, nombre, descripción, km y minutos.
class _LugarFrecuente extends StatelessWidget {
  final Lugar lugar;
  final bool seleccionado;
  final double distanciaKm;
  final int minutos;
  final VoidCallback onTap;

  const _LugarFrecuente({
    required this.lugar,
    required this.seleccionado,
    required this.distanciaKm,
    required this.minutos,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final oscuro = tema.brightness == Brightness.dark;

    return Tarjeta(
      onTap: onTap,
      resaltada: seleccionado,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: seleccionado ? AppColors.lima : (oscuro ? AppColors.bosque : AppColors.pistache),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.location_on_outlined,
              color: seleccionado || !oscuro ? AppColors.bosque : AppColors.lima,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lugar.nombre, style: tema.textTheme.labelLarge),
                Text(lugar.descripcion, style: tema.textTheme.bodySmall?.copyWith(fontSize: 13)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(Formatos.km(distanciaKm), style: tema.textTheme.labelLarge),
              Row(
                children: [
                  Icon(Icons.schedule_rounded, size: 14, color: tema.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 3),
                  Text(Formatos.minutos(minutos), style: tema.textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
