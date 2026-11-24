import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/widgets/widgets.dart';
import '../../login/login.dart';
import '../models/servicio_transporte_model.dart';
import '../repositories/servicios_repository.dart';
import '../widgets/tarjeta_servicio_widget.dart';

/// Pestaña Inicio del pasajero: saludo, buscador, banner y catálogo de servicios.
class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  // Se guarda el Future para no volver a pedir los datos en cada redibujo.
  late final Future<List<ServicioTransporte>> _servicios =
      ServiciosRepository.instancia.obtenerServicios();
  String _busqueda = '';

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final usuario = SesionRepository.instancia.usuarioActual.value;

    return Scaffold(
      appBar: ServiAppBar(
        titulo: '¡Hola, ${usuario?.nombreCorto ?? 'viajero'}!',
        subtitulo: '¿A dónde vamos hoy?',
        accion: AvatarIniciales(iniciales: usuario?.iniciales ?? '?'),
      ),
      // FutureBuilder dibuja según el estado del Future: cargando, error o listo.
      body: FutureBuilder<List<ServicioTransporte>>(
        future: _servicios,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const EstadoCargaDatos();
          }
          if (snapshot.hasError) return EstadoCargaDatos(error: '${snapshot.error}');

          final filtro = _busqueda.toLowerCase();
          final servicios = snapshot.data!
              .where((s) => s.nombre.toLowerCase().contains(filtro))
              .toList();

          return ListView(
            // Abajo 120 px para que la barra flotante no tape la última tarjeta.
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 120),
            children: [
              _Buscador(alCambiar: (texto) => setState(() => _busqueda = texto)),
              const SizedBox(height: 20),
              const _Banner(),
              const SizedBox(height: 28),
              Text('Servicios', style: tema.textTheme.titleMedium?.copyWith(fontSize: 20)),
              const SizedBox(height: 14),
              if (servicios.isEmpty)
                const EstadoVacio(
                  icono: Icons.search_off_rounded,
                  titulo: 'Sin resultados',
                  mensaje: 'Ningún servicio coincide con tu búsqueda.',
                ),
              for (final servicio in servicios) ...[
                TarjetaServicio(
                  servicio: servicio,
                  onTap: () => Navigator.pushNamed(
                    context,
                    Rutas.detalleServicio,
                    arguments: servicio, // El detalle recibe el servicio elegido
                  ),
                ),
                const SizedBox(height: 14),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// Campo de búsqueda redondo. Filtra los servicios por nombre.
class _Buscador extends StatelessWidget {
  final ValueChanged<String> alCambiar;
  const _Buscador({required this.alCambiar});

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final borde = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: colores.outline),
    );
    return TextField(
      onChanged: alCambiar,
      decoration: InputDecoration(
        hintText: 'Buscar servicio',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: const Icon(Icons.location_on_outlined),
        filled: true,
        fillColor: colores.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: borde,
        enabledBorder: borde,
        focusedBorder: borde.copyWith(borderSide: BorderSide(color: colores.primary)),
      ),
    );
  }
}

/// Banner verde: "Tlaxiaco, Oaxaca · Viajes locales con precio claro antes de salir".
class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    final oscuro = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.bosque,
        borderRadius: BorderRadius.circular(24),
        border: oscuro ? Border.all(color: AppColors.lima.withValues(alpha: 0.3)) : null,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tlaxiaco, Oaxaca',
            style: TextStyle(color: AppColors.lima, fontSize: 13, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 6),
          Text(
            'Viajes locales con precio claro antes de salir',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
