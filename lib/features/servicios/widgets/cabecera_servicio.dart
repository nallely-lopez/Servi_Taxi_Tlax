import 'package:flutter/material.dart';

import '../models/servicio_transporte_model.dart';

class CabeceraServicio extends StatelessWidget {
  final ServicioTransporte servicio;

  const CabeceraServicio({
    super.key,
    required this.servicio,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: double.infinity,
        height: 220,
        child: Image.network(
          servicio.imagen,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey.shade300,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image, size: 60, color: Colors.grey),
                SizedBox(height: 8),
                Text(
                  'Imagen no disponible',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
