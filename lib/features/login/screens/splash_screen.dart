import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../servicios/servicios.dart';
import '../../viajes/viajes.dart';
import '../repositories/sesion_repository.dart';
import '../widgets/logo_servitlax_widget.dart';

/// Pantalla de bienvenida: muestra el logo y una barra de carga mientras
/// se cargan los datos (usuarios, servicios, lugares y viajes). Luego va al Login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// SingleTickerProviderStateMixin da el "reloj" que necesita un AnimationController.
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _barra = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void initState() {
    super.initState();
    _iniciar();
  }

  Future<void> _iniciar() async {
    // Las dos cosas pasan al mismo tiempo: la animación y la carga de datos.
    // Future.wait espera a que terminen ambas.
    await Future.wait([
      _barra.forward(),
      SesionRepository.instancia.cargar(),
      ServiciosRepository.instancia.obtenerServicios(),
      LugaresRepository.instancia.cargar(),
      ViajesRepository.instancia.cargar(),
    ]);
    // mounted = la pantalla sigue abierta. Siempre revisarlo después de un await.
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Rutas.login);
  }

  @override
  void dispose() {
    _barra.dispose(); // Liberar el controlador para no gastar memoria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bosque,
      body: Stack(
        children: [
          // Círculos decorativos de las esquinas
          Positioned(top: -80, right: -80, child: _circulo(240)),
          Positioned(bottom: -120, left: -90, child: _circulo(300)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LogoServiTlax(tamano: 34, sobreOscuro: true),
                const SizedBox(height: 20),
                Text(
                  'Muévete por Tlaxiaco, fácil y seguro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 64,
            right: 64,
            bottom: 90,
            child: Column(
              children: [
                // AnimatedBuilder redibuja la barra en cada cuadro de la animación.
                AnimatedBuilder(
                  animation: _barra,
                  builder: (context, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _barra.value,
                      minHeight: 6,
                      color: AppColors.lima,
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Cargando...',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circulo(double tamano) => Container(
    width: tamano,
    height: tamano,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.07),
      shape: BoxShape.circle,
    ),
  );
}
