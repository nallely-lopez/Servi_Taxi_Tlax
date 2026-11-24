import 'package:flutter/material.dart';

import '../../features/perfil/perfil.dart';
import '../../features/servicios/servicios.dart';
import '../../features/viajes/viajes.dart';
import '../../shared/widgets/widgets.dart';

/// Contenedor del pasajero: barra inferior con Inicio, Viajes y Perfil.
/// IndexedStack mantiene vivas las 3 pantallas y solo muestra una:
/// al cambiar de pestaña no se pierde el scroll ni lo escrito.
class ShellPasajero extends StatelessWidget {
  const ShellPasajero({super.key});

  /// Pestaña visible. Es estático para que otras pantallas puedan cambiarla,
  /// por ejemplo Confirmación → "Ver mis viajes" pone 1.
  static final ValueNotifier<int> pestana = ValueNotifier(0);

  static const _items = [
    ItemNavegacion(Icons.home_outlined, 'Inicio'),
    ItemNavegacion(Icons.route_outlined, 'Viajes'),
    ItemNavegacion(Icons.person_outline_rounded, 'Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: pestana,
      builder: (context, indice, _) => Scaffold(
        extendBody: true, // El contenido pasa por detrás de la barra flotante
        body: IndexedStack(
          index: indice,
          children: const [InicioScreen(), MisViajesScreen(), PerfilScreen()],
        ),
        bottomNavigationBar: BarraNavegacion(
          indiceActual: indice,
          alCambiar: (i) => pestana.value = i,
          items: _items,
        ),
      ),
    );
  }
}
