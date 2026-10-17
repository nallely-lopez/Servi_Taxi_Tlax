import 'package:flutter/material.dart';
import '../../../shared/widgets/boton_principal_widget.dart';
import '../../../shared/widgets/estado_carga_datos_widget.dart';
import '../../servicios/models/servicio_transporte_model.dart';
import '../models/lugar.dart';
import '../models/ruta.dart';
import '../models/viaje.dart';
import '../utils/calculadora_viaje_utils.dart';
import '../utils/lector_lugares_utils.dart';
import '../utils/lector_rutas_utils.dart';
import '../widgets/selector_lugar_widget.dart';

class SeleccionRecorridoScreen extends StatefulWidget {
  final ServicioTransporte servicio;

  const SeleccionRecorridoScreen({
    super.key,
    required this.servicio,
  });

  @override
  State<SeleccionRecorridoScreen> createState() => _SeleccionRecorridoScreenState();
}

class _SeleccionRecorridoScreenState extends State<SeleccionRecorridoScreen> {
  late Future<List<Lugar>> _futureLugares;
  late Future<List<Ruta>> _futureRutas;

  Lugar? _origenSeleccionado;
  Lugar? _destinoSeleccionado;
  String? _mensajeError;

  @override
  void initState() {
    super.initState();
    _futureLugares = LectorLugaresUtils.cargarLugares();
    _futureRutas = LectorRutas.cargarRutas();
  }

  void _validarYContinuar(List<Ruta> rutas) {
    setState(() {
      _mensajeError = null;
    });

    // Validación 1: Selección incompleta
    if (_origenSeleccionado == null || _destinoSeleccionado == null) {
      setState(() {
        _mensajeError = 'Por favor selecciona el lugar de origen y de destino.';
      });
      return;
    }

    // Validación 2: Origen igual a destino
    if (_origenSeleccionado!.id == _destinoSeleccionado!.id) {
      setState(() {
        _mensajeError = 'El origen y el destino no pueden ser el mismo lugar.';
      });
      return;
    }

    // Validación 3: Ruta inexistente entre origen y destino
    final rutaEncontrada = rutas.cast<Ruta?>().firstWhere(
      (r) =>
          r?.origenId == _origenSeleccionado!.id &&
          r?.destinoId == _destinoSeleccionado!.id,
      orElse: () => null,
    );

    if (rutaEncontrada == null) {
      setState(() {
        _mensajeError =
            'Ruta no disponible: no hay trayecto registrado entre los puntos seleccionados.';
      });
      return;
    }

    // Cálculo del costo estimado fuera del build
    final costo = CalculadoraViaje.calcularCosto(
      tarifaBase: widget.servicio.tarifaBase,
      distanciaKm: rutaEncontrada.distanciaKm,
      precioKm: widget.servicio.precioKm,
    );

    // Instancia en memoria de Viaje
    final viaje = Viaje(
      servicio: widget.servicio,
      origen: _origenSeleccionado!,
      destino: _destinoSeleccionado!,
      ruta: rutaEncontrada,
      costoEstimado: costo,
    );

    // El enlace definitivo con CotizacionScreen se consolidará en el Paso 21
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Recorrido validado (${rutaEncontrada.distanciaKm} km) - Total: \$${viaje.costoEstimado.toStringAsFixed(2)}',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Recorrido'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([_futureLugares, _futureRutas]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const EstadoCargaDatos();
          }

          if (snapshot.hasError) {
            return EstadoCargaDatos(
              mensajeError: 'Error al cargar lugares o rutas: ${snapshot.error}',
            );
          }

          final lugares = (snapshot.data?[0] as List<Lugar>?) ?? [];
          final rutas = (snapshot.data?[1] as List<Ruta>?) ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.blueAccent),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Servicio seleccionado: ${widget.servicio.nombre}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SelectorLugar(
                  etiqueta: 'Origen',
                  valorSeleccionado: _origenSeleccionado,
                  lugares: lugares,
                  onChanged: (Lugar? nuevoOrigen) {
                    setState(() {
                      _origenSeleccionado = nuevoOrigen;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SelectorLugar(
                  etiqueta: 'Destino',
                  valorSeleccionado: _destinoSeleccionado,
                  lugares: lugares,
                  onChanged: (Lugar? nuevoDestino) {
                    setState(() {
                      _destinoSeleccionado = nuevoDestino;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (_mensajeError != null)
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade400),
                    ),
                    child: Text(
                      _mensajeError!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                  ),
                BotonPrincipal(
                  texto: 'Cotizar Viaje',
                  onPressed: () => _validarYContinuar(rutas),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}