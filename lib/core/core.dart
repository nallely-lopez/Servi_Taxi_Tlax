/// Archivo de barril: todo core/ (constantes, servicios y utilidades).
/// Solo reexporta archivos. Para usarlos basta UNA línea de import.
/// core/navigation NO se exporta aquí: el router importa las pantallas y
/// las pantallas importan este barril; exportarlo formaría un ciclo.
library;

export 'constants/contratos.dart';
export 'constants/rutas.dart';
export 'services/json_local_service.dart';
export 'utils/formatos.dart';
