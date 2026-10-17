import 'package:flutter/material.dart';
import '../models/servicio_transporte_model.dart';

class DetalleServicioScreen extends StatelessWidget {
  final ServicioTransporte servicio;

  const DetalleServicioScreen({super.key, required this.servicio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(servicio.nombre),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen principal del servicio
            SizedBox(
              height: 220,
              child: Image.network(
                servicio.imagen,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    servicio.nombre,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    servicio.descripcion,
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade800, height: 1.3),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  const Text(
                    'Especificaciones y Tarifas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoTile(
                        icon: Icons.people,
                        label: 'Capacidad',
                        value: '${servicio.capacidad} pers.',
                      ),
                      _buildInfoTile(
                        icon: Icons.attach_money,
                        label: 'Tarifa Base',
                        value: '\$${servicio.tarifaBase.toStringAsFixed(2)}',
                      ),
                      _buildInfoTile(
                        icon: Icons.add_road,
                        label: 'Precio por Km',
                        value: '\$${servicio.precioKm.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  const Text(
                    'Características del servicio',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: servicio.caracteristicas
                        .map((item) => Chip(
                              avatar: const Icon(Icons.check_circle, color: Colors.green, size: 18),
                              label: Text(item),
                              backgroundColor: Colors.blue.shade50,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // La conexión hacia Selección de Recorrido se hará en el Paso 23
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Siguiente paso: Seleccionar recorrido'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.navigation),
                      label: const Text('Continuar a Selección de Recorrido', style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 28),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }
}