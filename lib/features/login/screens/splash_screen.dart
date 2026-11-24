import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../servicios/servicios.dart';
import '../../viajes/viajes.dart';
import '../repositories/sesion_repository.dart';

/// PROVISIONAL (Fase A). Carga los datos y pasa al Login.
/// Se reemplaza en el Paso 25 por el Splash real con logo y barra de carga.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    await SesionRepository.instancia.cargar();
    await ServiciosRepository.instancia.obtenerServicios();
    await LugaresRepository.instancia.cargar();
    await ViajesRepository.instancia.cargar();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Rutas.login);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
