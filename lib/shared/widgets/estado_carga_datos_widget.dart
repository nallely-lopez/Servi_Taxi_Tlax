import 'package:flutter/material.dart';

/// Lo que se muestra mientras un FutureBuilder espera datos o si falla.
/// Uso típico:
///   if (snapshot.connectionState != ConnectionState.done) return const EstadoCargaDatos();
///   if (snapshot.hasError) return EstadoCargaDatos(error: '${snapshot.error}');
class EstadoCargaDatos extends StatelessWidget {
  final String? error; // null = cargando; texto = falló

  const EstadoCargaDatos({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: error == null
            ? CircularProgressIndicator(color: colores.primary)
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: colores.error,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No se pudieron cargar los datos.\n$error',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
