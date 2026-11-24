/// Archivo de barril: funcionalidad servicios.
/// Solo reexporta archivos. Para usarlos basta UNA línea de import.
/// Exporta models, repositories y screens. NO exporta services ni widgets:
/// los services solo los usa su repositorio y los widgets solo sus pantallas.
/// Dentro de esta carpeta los archivos se importan entre sí directamente.
library;

export 'models/servicio_transporte_model.dart';
export 'repositories/servicios_repository.dart';
export 'screens/detalle_servicio_screen.dart';
export 'screens/inicio_screen.dart';
