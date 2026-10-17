import 'package:flutter/material.dart';

import '../../autenticacion/models/usuario_model.dart';
import '../models/servicio_transporte_model.dart';
import '../utils/lector_servicios_utils.dart';
import '../widgets/tarjeta_servicios_widget.dart';
import '../../../shared/widgets/estado_carga_datos_widget.dart';
import 'detalle_servicio_screen.dart';

class ServiciosScreen extends StatefulWidget {
  final Usuario usuario;

  const ServiciosScreen({super.key, required this.usuario});

  @override
  State<ServiciosScreen> createState() => _ServiciosScreenState();
}

class _ServiciosScreenState extends State<ServiciosScreen> {
  late Future<List<ServicioTransporte>> _futureServicios;

  @override
  void initState() {
    super.initState();
    _futureServicios = LectorServicios.cargarServicios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Servicios'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.blueAccent.withValues(alpha: 0.1),
            child: Text(
              'Hola, ${widget.usuario.nombre}. Elige tu servicio de transporte:',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ServicioTransporte>>(
              future: _futureServicios,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const EstadoCargaDatos();
                }

                if (snapshot.hasError) {
                  return EstadoCargaDatos(
                    mensajeError:
                        'Error al cargar el catálogo: ${snapshot.error}',
                  );
                }

                final servicios = snapshot.data ?? [];

                if (servicios.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay servicios disponibles en este momento.',
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: servicios.length,
                  itemBuilder: (context, index) {
                    final servicio = servicios[index];
                    return TarjetaServicio(
                      servicio: servicio,
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetalleServicioScreen(servicio: servicio),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
