import 'package:flutter/material.dart';

class EstadoCargaDatos extends StatelessWidget {
  final String? mensajeError;

  const EstadoCargaDatos({super.key, this.mensajeError});

  @override
  Widget build(BuildContext context) {
    if (mensajeError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 12),
              Text(
                mensajeError!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return const Center(child: CircularProgressIndicator());
  }
}
