import 'package:flutter/material.dart';
import '../../../shared/widgets/boton_principal_widget.dart';
import '../models/servicio_transporte_model.dart';
import '../widgets/cabecera_servicio.dart';
import '../widgets/ficha_servicio.dart';
import '../../viajes/screens/seleccion_recorrido_screen.dart';

class DetalleServicioScreen extends StatelessWidget {
  final ServicioTransporte servicio;

  const DetalleServicioScreen({
    super.key,
    required this.servicio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(servicio.nombre),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CabeceraServicio(servicio: servicio),
            const SizedBox(height: 16),
            Text(
              servicio.nombre,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              servicio.descripcion,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
            ),
            const SizedBox(height: 16),
            FichaServicio(servicio: servicio),
            const SizedBox(height: 24),
            BotonPrincipal(
              texto: 'Seleccionar Recorrido',
              onPressed: () async {
                final resultado = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SeleccionRecorridoScreen(servicio: servicio),
                  ),
                );
                if (!context.mounted) return;
                if (resultado == true) Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }
}