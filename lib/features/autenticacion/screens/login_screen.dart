import 'package:flutter/material.dart';

import '../../../shared/widgets/boton_principal_widget.dart';
import '../../servicios/screens/servicios_screen.dart';
import '../models/usuario_model.dart';
import '../utils/lector_usuarios_utils.dart';
import '../widgets/campo_acceso_widget.dart';

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

      final usuarioEncontrado = usuarios.cast<Usuario?>().firstWhere(
        (u) => u?.usuario == usuarioTexto && u?.claveAcceso == claveTexto,
        orElse: () => null,
      );

      if (!mounted) return;

      setState(() {
        _cargando = false;
      });

      if (usuarioEncontrado != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiciosScreen(usuario: usuarioEncontrado),
          ),
        );
      } else {
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
              CampoAcceso(
                etiqueta: 'Usuario',
                controlador: _usuarioController,
                icono: Icons.person,
              ),
              const SizedBox(height: 16),
              CampoAcceso(
                etiqueta: 'Contraseña',
                controlador: _claveController,
                icono: Icons.lock,
                ocultarTexto: true,
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
              BotonPrincipal(
                texto: 'Ingresar',
                onPressed: _iniciarSesion,
                estaCargando: _cargando,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
