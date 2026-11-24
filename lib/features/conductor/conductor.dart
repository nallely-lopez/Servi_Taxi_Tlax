/// Archivo de barril: funcionalidad conductor.
/// Solo reexporta archivos. Para usarlos basta UNA línea de import.
/// Exporta models, repositories y screens. NO exporta services ni widgets:
/// los services solo los usa su repositorio y los widgets solo sus pantallas.
/// Dentro de esta carpeta los archivos se importan entre sí directamente.
library;

export 'screens/detalle_solicitud_screen.dart';
export 'screens/solicitudes_screen.dart';
export 'screens/viajes_aceptados_screen.dart';
