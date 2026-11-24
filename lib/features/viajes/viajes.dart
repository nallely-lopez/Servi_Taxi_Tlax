/// Archivo de barril: funcionalidad viajes.
/// Solo reexporta archivos. Para usarlos basta UNA línea de import.
/// Exporta models, repositories y screens. NO exporta services ni widgets:
/// los services solo los usa su repositorio y los widgets solo sus pantallas.
/// Dentro de esta carpeta los archivos se importan entre sí directamente.
library;

export 'models/cotizacion_model.dart';
export 'models/lugar_model.dart';
export 'models/ruta_model.dart';
export 'models/viaje_model.dart';
export 'repositories/lugares_repository.dart';
export 'repositories/viajes_repository.dart';
