import 'package:flutter/material.dart';

import '../../core/core.dart';

/// Imagen del recorrido. Por decisión del equipo, en la app el mapa interactivo
/// se reemplaza por una imagen. Si existe assets/images/mapa_tlaxiaco.png se usa;
/// si no, se dibuja un recuadro con el origen y el destino.
class MapaRecorrido extends StatelessWidget {
  final String origen;
  final String destino;

  const MapaRecorrido({super.key, required this.origen, required this.destino});

  @override
  Widget build(BuildContext context) {
    final oscuro = Theme.of(context).brightness == Brightness.dark;
    final fondo = oscuro ? AppColors.suaveOscuro : AppColors.suave;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 190,
        width: double.infinity,
        child: Image.asset(
          'assets/images/mapa_tlaxiaco.png',
          fit: BoxFit.cover,
          // errorBuilder se usa cuando la imagen no existe todavía.
          errorBuilder: (context, error, stack) => Container(
            color: fondo,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                _Punto(nombre: origen, relleno: false),
                Expanded(
                  child: Container(
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: oscuro ? AppColors.lima : AppColors.bosque,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                _Punto(nombre: destino, relleno: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Marcador con el nombre del lugar debajo.
class _Punto extends StatelessWidget {
  final String nombre;
  final bool relleno;

  const _Punto({required this.nombre, required this.relleno});

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return SizedBox(
      width: 96,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            relleno ? Icons.location_on_rounded : Icons.trip_origin_rounded,
            size: 34,
            color: colores.primary,
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colores.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              nombre,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
