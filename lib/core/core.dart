/// Archivo de barril: todo core/ (constantes, tema, servicios y utilidades).
/// Solo reexporta archivos. Para usarlos basta UNA línea de import.
/// core/navigation NO se exporta aquí: el router importa las pantallas y
/// las pantallas importan este barril; exportarlo formaría un ciclo.
library;

export 'constants/contratos.dart';
export 'constants/rutas.dart';
export 'services/json_local_service.dart';
export 'theme/app_colors.dart';
export 'theme/app_theme.dart';
export 'theme/theme_controller.dart';
export 'utils/formatos.dart';
