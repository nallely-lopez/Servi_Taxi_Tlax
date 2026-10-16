import 'package:flutter/material.dart';

import '../../servicios/screens/servicios_screen.dart';
import '../models/usuario_model.dart';
import '../utils/lector_usuarios_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();

  String? _mensajeError;
  bool _cargando = false;

  @override
  void dispose() {
    _usuarioController.dispose();
    _claveController.dispose();
    super.dispose();
  }

  Future<void> _iniciarSesion() async {
    final usuarioTexto = _usuarioController.text.trim();
    final claveTexto = _claveController.text.trim();

    setState(() {
      _mensajeError = null;
    });

    // Validación 1: Campos vacíos
    if (usuarioTexto.isEmpty || claveTexto.isEmpty) {
      setState(() {
        _mensajeError = 'Por favor ingresa usuario y contraseña.';
      });
      return;
    }

    setState(() {
      _cargando = true;
    });

    try {
      final List<Usuario> usuarios = await LectorUsuarios.cargarUsuarios();

      // Buscar coincidencia en usuarios.json
      final usuarioEncontrado = usuarios.cast<Usuario?>().firstWhere(
        (u) => u?.usuario == usuarioTexto && u?.claveAcceso == claveTexto,
        orElse: () => null,
      );

      if (!mounted) return;

      setState(() {
        _cargando = false;
      });

      if (usuarioEncontrado != null) {
        // Conexión exitosa: Navega al catálogo de servicios pasando el usuario
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiciosScreen(usuario: usuarioEncontrado),
          ),
        );
      } else {
        // Validación 2: Credenciales incorrectas
        setState(() {
          _mensajeError = 'Usuario o contraseña incorrectos.';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _cargando = false;
        _mensajeError = 'Error al cargar los datos de autenticación.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transporte Local - Acceso'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.local_taxi, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 16),
              const Text(
                'Iniciar Sesión',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _usuarioController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _claveController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16),
              if (_mensajeError != null)
                Container(
                  padding: const EdgeInsets.all(8.0),
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
              ElevatedButton(
                onPressed: _cargando ? null : _iniciarSesion,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _cargando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Ingresar', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
