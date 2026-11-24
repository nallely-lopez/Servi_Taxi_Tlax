import 'package:flutter/material.dart';

import '../../features/conductor/conductor.dart';
import '../../features/perfil/perfil.dart';
import '../../shared/widgets/widgets.dart';

/// Contenedor del conductor: barra inferior con Solicitudes, Mis viajes y Perfil.
/// Funciona igual que ShellPasajero.
class ShellConductor extends StatelessWidget {
  const ShellConductor({super.key});

  /// Pestaña visible; Detalle de la solicitud la cambia a 1 al aceptar un viaje.
  static final ValueNotifier<int> pestana = ValueNotifier(0);

  static const _items = [
    ItemNavegacion(Icons.inbox_outlined, 'Solicitudes'),
    ItemNavegacion(Icons.checklist_rounded, 'Mis viajes'),
    ItemNavegacion(Icons.person_outline_rounded, 'Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: pestana,
      builder: (context, indice, _) => Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: indice,
          children: const [
            SolicitudesScreen(),
            ViajesAceptadosScreen(),
            PerfilScreen(),
          ],
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
